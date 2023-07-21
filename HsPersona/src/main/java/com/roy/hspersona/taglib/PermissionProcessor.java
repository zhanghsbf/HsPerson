package com.roy.hspersona.taglib;

import com.roy.hspersona.common.SessionBean;
import com.roy.hspersona.config.SpringContext;
import com.roy.hspersona.util.LoginedSessionHolder;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.thymeleaf.context.ITemplateContext;
import org.thymeleaf.model.IProcessableElementTag;
import org.thymeleaf.processor.element.AbstractElementTagProcessor;
import org.thymeleaf.processor.element.IElementTagStructureHandler;
import org.thymeleaf.templatemode.TemplateMode;

import javax.servlet.http.HttpSession;

/**
 * @author roy
 * @date 2021/12/3
 * @desc
 */
public class PermissionProcessor extends AbstractElementTagProcessor {
    private static final String COMMAND_NAME="permission";
    private static final int PRECEDENCE = 10000;

    public PermissionProcessor(String dialectPrefix) {
        super(TemplateMode.HTML,
                dialectPrefix,
                COMMAND_NAME,
                true,
                null,
                false,
                PRECEDENCE);
    }
    @Override
    protected void doProcess(ITemplateContext iTemplateContext, IProcessableElementTag iProcessableElementTag, IElementTagStructureHandler iElementTagStructureHandler) {
        final String code = iProcessableElementTag.getAttributeValue("code");
        if(StringUtils.isEmpty(code)){ //没有传code ,快速隐藏元素
            iElementTagStructureHandler.removeElement();
        }else{
            final String sessionId = RequestContextHolder.getRequestAttributes().getSessionId();
            final HttpSession session = LoginedSessionHolder.getSessionById(sessionId);
            if(null == session){ //没有记录登录Session，快速隐藏元素
                iElementTagStructureHandler.removeElement();
            }else{
                final Object userSession = session.getAttribute("userSession");
                if(null == userSession){ // 登录Session中没有获取到登录用户，快速隐藏元素
                    iElementTagStructureHandler.removeElement();
                }else{
                    final SessionBean sessionBean = (SessionBean) userSession;
                    if (null == sessionBean || sessionBean.getPermissionMap().get(code) == null) {
                        iElementTagStructureHandler.removeElement();
                    }
                }
            }
        }
    }
}
