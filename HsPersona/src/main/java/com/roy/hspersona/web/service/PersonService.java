package com.roy.hspersona.web.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.parser.ParserConfig;
import com.roy.hspersona.common.ConstantDict;
import com.roy.hspersona.util.DateUtil;
import com.roy.hspersona.util.NumUtil;
import com.roy.hspersona.web.anno.TagElement;
import com.roy.hspersona.web.entity.DataVO;
import com.roy.hspersona.web.entity.PersonVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/16
 * @desc
 */
@Service
public class PersonService {
    private List<String> descAttribList = null;
    private JSONObject sourceJson = null;

    public List<PersonVO> getPersonVOByDataVOs(List<DataVO> dataVOs) {
        if (dataVOs == null) {
            return null;
        }
        List<PersonVO> personVOList = new ArrayList<>();
        for (DataVO dataVO : dataVOs) {
            PersonVO personVO = this.getPersonVOFromDataVO(dataVO);
            personVOList.add(personVO);
        }
        return personVOList;
    }

    public PersonVO getPersonVOFromDataVO(DataVO dataVO){
        PersonVO personVO = new PersonVO();
        ParserConfig.getGlobalInstance().setAutoTypeSupport(true);
        JSONObject sourceJson = JSON.parseObject(dataVO.getSource());

        // 主键ID
        personVO.setId(dataVO.getId());

        for (Field field : personVO.getClass().getDeclaredFields()) {
            if(field.isAnnotationPresent(TagElement.class)){
                try {
                    TagElement tagElement = field.getAnnotation(TagElement.class);
                    String tagVal = tagElement.value();
                    String formatMethodName = tagElement.formatMethod();
                    Object sourceVal = sourceJson.get(tagVal);
                    if(StringUtils.isNotEmpty(formatMethodName)){
                        Method formatMethond = FormatService.class.getMethod(formatMethodName, String.class);
                        if(null != formatMethond){
                            sourceVal = formatMethond.invoke(null, sourceVal);
                        }
                    }
                    field.setAccessible(true);
                    field.set(personVO,sourceVal);
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (InvocationTargetException e) {
                    e.printStackTrace();
                } catch (NoSuchMethodException e) {
                    e.printStackTrace();
                }
            }
        }

        // 标签列表,过去的标签直接忽略
        JSONArray tagJsonArray = (JSONArray) sourceJson.get("@tag");
        if (null != tagJsonArray && !tagJsonArray.isEmpty()) {
            for (int i = 0; i < tagJsonArray.size(); i++) {
                JSONObject tagJsonObj = tagJsonArray.getJSONObject(i);
                if (tagJsonObj.getInteger("isLatest") == 1) {
                    personVO.getTagNames().add(tagJsonObj.getString("tagName"));
                }
            }
        }
        // 个人描述
//            List<String> descAttribList = new ArrayList<>();
//            descAttribList.add("nation");
//            descAttribList.add("birth");
//            descAttribList.add("education");
//            descAttribList.add("product");
//            String description = this.getDescription(descAttribList, sourceJson);
        String description = FormatService.getDescription(personVO,sourceJson);
        personVO.setDescription(description);
        return personVO;
    }

    public String getDescription(List<String> descAttribList, JSONObject sourceJson) {
        this.descAttribList = descAttribList;
        this.sourceJson = sourceJson;
        StringBuffer sb = new StringBuffer();
        // 性别
        if (this.canFetchData("gender")) {
            String gender = (String) sourceJson.get("gender");
            Map<String, String> genderMap = ConstantDict.tagDictMap.get("gender");
            if (genderMap.get(gender) != null) {
                sb.append(this.getNormal2P("性别", genderMap.get(gender)));
            }
            descAttribList.remove("gender");
        }
        // 民族
        if (this.canFetchData("nation")) {
            String nation = (String) sourceJson.get("nation");
            Map<String, String> nationMap = ConstantDict.tagDictMap.get("nation");
            if (nationMap != null && nationMap.get(nation) != null) {
                sb.append(this.getNormal1P(nationMap.get(nation)));
            }
            descAttribList.remove("nation");
        }
        // 出生信息
        if (descAttribList.contains("birth")) {
            sb.append(this.getBirth());
            descAttribList.remove("birth");
        }
        // 教育信息
        if (descAttribList.contains("education")) {
            sb.append(this.getEducation());
            descAttribList.remove("education");
        }
        // 产品信息
        if (descAttribList.contains("product")) {
            sb.append(this.getProduct());
            descAttribList.remove("product");
        }
        return sb.toString();
    }

    private boolean canFetchData(String... keys) {
        if (this.descAttribList == null || this.sourceJson == null) {
            return false;
        }
        for (String key : keys) {
            if (!this.descAttribList.contains(key)) {
                return false;
            }
            JSONObject json = this.sourceJson;
            while (key.indexOf(".") >= 0) {
                if (json == null) {
                    return false;
                }
                try {
                    json = json.getJSONObject(key.substring(0, key.indexOf(".")));
                } catch (Exception e) {
                    json = json.getJSONArray(key.substring(0, key.indexOf("."))).getJSONObject(0);
                }
                key = key.substring(key.indexOf(".") + 1);
            }
            if (json.get(key) == null) {
                return false;
            }
        }
        return true;
    }

    private String getNormal2P(String prefix, String gender) {
        return prefix + gender + "。";
    }

    private String getNormal1P(String key) {
        return key + "。";
    }

    private String getBirth() {
        String originPlace = (String) sourceJson.get("originPlace");
        String birthDate = (String) sourceJson.get("birthDate");
        StringBuffer sb = new StringBuffer();

        if (StringUtils.isNotEmpty(originPlace) && StringUtils.isNotEmpty(birthDate)) {
            birthDate = birthDate.replace("-", "").replace("/", "");
            sb.append((birthDate.length() >= 4) ? (birthDate.substring(0, 4) + "年") : "");
            sb.append((birthDate.length() >= 6) ? (Integer.parseInt(birthDate.substring(4, 6)) + "月") : "");
            sb.append((birthDate.length() >= 8) ? (Integer.parseInt(birthDate.substring(6, 8)) + "日") : "");
            sb.append("出生于").append(originPlace).append("。");
        } else if (StringUtils.isNotEmpty(birthDate)) {
            birthDate = birthDate.replace("-", "").replace("/", "");
            sb.append((birthDate.length() >= 4) ? (birthDate.substring(0, 4) + "年") : "");
            sb.append((birthDate.length() >= 6) ? (Integer.parseInt(birthDate.substring(4, 6)) + "月") : "");
            sb.append((birthDate.length() >= 8) ? (Integer.parseInt(birthDate.substring(6, 8)) + "日") : "");
            sb.append("出生。");
        } else if (StringUtils.isNotEmpty(originPlace)) {
            return "出生于" + originPlace + "。";
        }
        return sb.toString();
    }

    private String getEducation() {
        JSONArray jsonArray = this.getJSONArray(this.sourceJson, "alumniOf");
        if (jsonArray == null || jsonArray.size() == 0) {
            return "";
        }
        int eduIndex = 0, index = 0;
        for (int i = 0; i < jsonArray.size(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            Object educated = jsonObject.get("educated");
            if (educated != null && Integer.parseInt((String) educated) > eduIndex) {
                eduIndex = Integer.parseInt((String) educated);
                index = i;
            }
        }
        JSONObject jsonObject = jsonArray.getJSONObject(index);
        String endDate = (String) jsonObject.get("endDate");
        String schoolLabel = (String) jsonObject.get("schoolLabel");
        String professional = (String) jsonObject.get("professional");
        StringBuffer sb = new StringBuffer();
        endDate = endDate.replace("-", "").replace("/", "");
        if (StringUtils.isNotEmpty(endDate) && StringUtils.isNotEmpty(schoolLabel) && StringUtils.isNotEmpty(professional)) {
            sb.append((endDate.length() >= 4) ? (endDate.substring(0, 4) + "年") : "");
            sb.append((endDate.length() >= 6) ? (Integer.parseInt(endDate.substring(4, 6)) + "月") : "");
            sb.append("毕业于").append(schoolLabel).append(professional).append("。");
        } else if (StringUtils.isNotEmpty(endDate) && StringUtils.isNotEmpty(schoolLabel)) {
            sb.append((endDate.length() >= 4) ? (endDate.substring(0, 4) + "年") : "");
            sb.append((endDate.length() >= 6) ? (Integer.parseInt(endDate.substring(4, 6)) + "月") : "");
            sb.append("毕业于").append(schoolLabel).append("。");
        } else if (StringUtils.isNotEmpty(professional) && StringUtils.isNotEmpty(schoolLabel)) {
            sb.append("就读于").append(schoolLabel).append(professional).append("。");
        } else if (StringUtils.isNotEmpty(endDate)) {
            sb.append((endDate.length() >= 4) ? (endDate.substring(0, 4) + "年") : "");
            sb.append((endDate.length() >= 6) ? (Integer.parseInt(endDate.substring(4, 6)) + "月") : "");
            sb.append("毕业。");
        } else if (StringUtils.isNotEmpty(schoolLabel)) {
            sb.append("毕业于").append(schoolLabel).append("。");
        }
        return sb.toString();
    }

    private String getProduct() {
        // 缺少币种代码
        JSONArray financing = this.getJSONArray(this.sourceJson, "financing");
        JSONArray fund = this.getJSONArray(this.sourceJson, "fund");
        JSONArray deposit = this.getJSONArray(this.sourceJson, "deposit");
        JSONArray creditCardQuota = this.getJSONArray(this.sourceJson, "creditCardQuota");
        JSONArray fundTargetInvestment = this.getJSONArray(this.sourceJson, "fundTargetInvestment");
        if ((financing == null || financing.size() == 0) && (deposit == null || deposit.size() == 0) && (fund == null || fund.size() == 0)
                && creditCardQuota == null && fundTargetInvestment == null) {
            return "目前暂无任何金融产品。";
        }
        StringBuffer sb = new StringBuffer("目前拥有的产品包括：");
        boolean haved = false;
        if (financing != null && financing.size() != 0) {
            sb.append("理财产品个数为").append(financing.size()).append("，");
            double sum = 0;
            for (int i = 0; i < financing.size(); i++) {
                JSONObject financingJson = financing.getJSONObject(i);
                if (financingJson.isEmpty()) {
                    // 如果为空，则不需要进行处理
                    continue;
                }
                double balance = 0;
                if (financingJson.get("balance") != null && StringUtils.isNotEmpty(financingJson.getString("balance"))) {
                    balance = financingJson.getDouble("balance");
                }
                sum = NumUtil.add(sum, balance);
            }
            sb.append("合计余额").append(sum);
            haved = true;
        }
        if (deposit != null && deposit.size() != 0) {
            sb.append(haved ? "；" : "");
            sb.append("存款产品个数为").append(deposit.size()).append("，");
            double sum = 0;
            for (int i = 0; i < deposit.size(); i++) {
                JSONObject depositJson = deposit.getJSONObject(i);
                if (depositJson.isEmpty()) {
                    continue;
                }
                double balance = 0;
                if (depositJson.get("balance") != null && StringUtils.isNotEmpty(depositJson.getString("balance"))) {
                    balance = depositJson.getDouble("balance");
                }
                sum = NumUtil.add(sum, balance);
            }
            sb.append("合计余额").append(sum);
            haved = true;
        }
        if (fund != null && fund.size() != 0) {
            sb.append(haved ? "；" : "");
            sb.append("基金产品个数为").append(fund.size()).append("，");
            double sum = 0;
            for (int i = 0; i < fund.size(); i++) {
                JSONObject fundJson = fund.getJSONObject(i);
                if (fundJson.isEmpty()) {
                    continue;
                }
                double balance = 0;
                if (fundJson.get("balance") != null && StringUtils.isNotEmpty(fundJson.getString("balance"))) {
                    balance = fundJson.getDouble("balance");
                }
                sum = NumUtil.add(sum, balance);
            }
            sb.append("合计余额").append(sum);
            haved = true;
        }
        if (creditCardQuota != null && !creditCardQuota.isEmpty()) {
            sb.append(haved ? "；" : "");
            sb.append("信用卡张数为").append(creditCardQuota.size()).append("，");
            double sum = 0;
            for (int i = 0; i < creditCardQuota.size(); i++) {
                JSONObject creditCardQuotaJson = creditCardQuota.getJSONObject(i);
                if (creditCardQuotaJson.isEmpty()) {
                    continue;
                }
                double balance = 0;
                if (creditCardQuotaJson.get("balance") != null && StringUtils.isNotEmpty(creditCardQuotaJson.getString("balance"))) {
                    balance = creditCardQuotaJson.getDouble("balance");
                }
                sum = NumUtil.add(sum, balance);
            }
            sb.append("信用卡合计额度").append(sum);
            haved = true;
        }
        if (fundTargetInvestment != null && !fundTargetInvestment.isEmpty()) {
            sb.append(haved ? "；" : "");
            sb.append("基金定投产品个数为").append(fundTargetInvestment.size()).append("，");
            double sum = 0;
            for (int i = 0; i < fundTargetInvestment.size(); i++) {
                JSONObject fundTargetInvestmentJson = fundTargetInvestment.getJSONObject(i);
                if (fundTargetInvestmentJson.isEmpty()) {
                    continue;
                }
                double balance = 0;
                if (fundTargetInvestmentJson.get("balance") != null && StringUtils.isNotEmpty(fundTargetInvestmentJson.getString("balance"))) {
                    balance = fundTargetInvestmentJson.getDouble("balance");
                }
                sum = NumUtil.add(sum, balance);
            }
            sb.append("基金定投产品合计金额").append(sum);
            haved = true;
        }
        sb.append(haved ? "。" : "");
        return sb.toString();
    }

    private JSONArray getJSONArray(JSONObject jsonObject, String key) {
        try {
            return jsonObject.getJSONArray(key);
        } catch (Exception e) {
            return null;
        }
    }
}
