package com.roy.hspersona.util;

import ch.ethz.ssh2.ChannelCondition;
import ch.ethz.ssh2.Connection;
import ch.ethz.ssh2.Session;
import ch.ethz.ssh2.StreamGobbler;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.common.ConstantParam;
import com.roy.hspersona.etl.entity.SqoopImportBean;

import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 * @author roy
 * @date 2021/12/9
 * @desc
 */
public class SSHCommand {
    public final static String ENTRY_CALCULATE = "com.zenisoft.usertageng.calculate.Entry";
    // 标签计算任务
    public final static String ENTRY_CALCULATE_AUTO = "com.roy.personaeng.calculate.CalculateJob";

    public final static String ENTRY_ETL = "com.roy.personaeng.etl.DataToJsonJob";
    // 二维表转JSON计算
    public final static String ENTRY_ETL_AUTO ="com.roy.personaeng.etl.DataToJsonJob";
    public final static String ENTRY_NAIVE_BAYES_CLASSIFIER_TRAIN = "com.zenisoft.usertageng.ml.classification.naivebayes.TrainEntry";
    public final static String ENTRY_NAIVE_BAYES_CLASSIFIER_SAVE = "com.zenisoft.usertageng.ml.classification.naivebayes.SaveEntry";
    public final static String ENTRY_NAIVE_BAYES_CLASSIFIER_RUN = "com.zenisoft.usertageng.ml.classification.naivebayes.RunEntry";
    public final static String ENTRY_DECISION_TREE_CLASSIFIER_TRAIN = "com.zenisoft.usertageng.ml.classification.decisiontree.TrainEntry";
    public final static String ENTRY_DECISION_TREE_CLASSIFIER_SAVE = "com.zenisoft.usertageng.ml.classification.decisiontree.SaveEntry";
    public final static String ENTRY_DECISION_TREE_CLASSIFIER_RUN = "com.zenisoft.usertageng.ml.classification.decisiontree.RunEntry";
    public final static String ENTRY_GBTREES_CLASSIFIER_TRAIN = "com.zenisoft.usertageng.ml.classification.gbtrees.TrainEntry";
    public final static String ENTRY_GBTREES_CLASSIFIER_SAVE = "com.zenisoft.usertageng.ml.classification.gbtrees.SaveEntry";
    public final static String ENTRY_GBTREES_CLASSIFIER_RUN = "com.zenisoft.usertageng.ml.classification.gbtrees.RunEntry";
    public final static String ENTRY_RANDOM_FOREST_CLASSIFIER_TRAIN = "com.zenisoft.usertageng.ml.classification.randomforest.TrainEntry";
    public final static String ENTRY_RANDOM_FOREST_CLASSIFIER_SAVE = "com.zenisoft.usertageng.ml.classification.randomforest.SaveEntry";
    public final static String ENTRY_RANDOM_FOREST_CLASSIFIER_RUN = "com.zenisoft.usertageng.ml.classification.randomforest.RunEntry";
    public final static String ENTRY_DECISION_TREE_REGRESSOR_TRAIN = "com.zenisoft.usertageng.ml.regression.decisiontree.TrainEntry";
    public final static String ENTRY_DECISION_TREE_REGRESSOR_SAVE = "com.zenisoft.usertageng.ml.regression.decisiontree.SaveEntry";
    public final static String ENTRY_DECISION_TREE_REGRESSOR_RUN = "com.zenisoft.usertageng.ml.regression.decisiontree.RunEntry";
    public final static String ENTRY_GBTREES_REGRESSOR_TRAIN = "com.zenisoft.usertageng.ml.regression.gbtrees.TrainEntry";
    public final static String ENTRY_GBTREES_REGRESSOR_SAVE = "com.zenisoft.usertageng.ml.regression.gbtrees.SaveEntry";
    public final static String ENTRY_GBTREES_REGRESSOR_RUN = "com.zenisoft.usertageng.ml.regression.gbtrees.RunEntry";
    public final static String ENTRY_RANDOM_FOREST_REGRESSOR_TRAIN = "com.zenisoft.usertageng.ml.regression.randomforest.TrainEntry";
    public final static String ENTRY_RANDOM_FOREST_REGRESSOR_SAVE = "com.zenisoft.usertageng.ml.regression.randomforest.SaveEntry";
    public final static String ENTRY_RANDOM_FOREST_REGRESSOR_RUN = "com.zenisoft.usertageng.ml.regression.randomforest.RunEntry";
    public final static String ENTRY_LINEAR_REGRESSOR_TRAIN = "com.zenisoft.usertageng.ml.regression.linear.TrainEntry";
    public final static String ENTRY_LINEAR_REGRESSOR_SAVE = "com.zenisoft.usertageng.ml.regression.linear.SaveEntry";
    public final static String ENTRY_LINEAR_REGRESSOR_RUN = "com.zenisoft.usertageng.ml.regression.linear.RunEntry";

    public final static String SESSIONID_IMPORT_FROM_RDB = "sessionid_import_from_rdb";
    public final static String SESSIONID_HADOOP_PUT="sessionid_hadoop_put";
    public final static String SESSIONID_ETL_JSON = "sessionid_etl_json";
    public final static String SESSIONID_CALCULATE = "sessionid_calculate";
    public final static String SESSIONID_NAIVE_BAYES_CLASSIFIER = "sessionid_naive_bayes_classifier";
    public final static String SESSIONID_DECISION_TREE_CLASSIFIER = "sessionid_decision_tree_classifier";
    public final static String SESSIONID_GBTREES_CLASSIFIER = "sessionid_gbtrees_classifier";
    public final static String SESSIONID_RANDOM_FOREST_CLASSIFIER = "sessionid_random_forest_classifier";
    public final static String SESSIONID_DECISION_TREE_REGRESSOR = "sessionid_decision_tree_regressor";
    public final static String SESSIONID_GBTREES_REGRESSOR = "sessionid_gbtrees_regressor";
    public final static String SESSIONID_RANDOM_FOREST_REGRESSOR = "sessionid_random_forest_regressor";
    public final static String SESSIONID_LINEAR_REGRESSOR = "sessionid_linear_regressor";

    private final static String SPARK_COMMIT_COMMAND_NORMAL = "%s/bin/spark-submit --class %s --master yarn %s %s";
    private final static String SQOOP_IMPORT_COMMAND_NORMAL = "%s/bin/sqoop import -Dorg.apache.sqoop.splitter.allow_text_splitter=true --connect %s --username %s --password %s --query '%s and $CONDITIONS' --fields-terminated-by '%s' --split-by %s --target-dir %s -m %d";
    private final static String HADOOP_PUT_FILE_COMMAND_NORMA="%s/bin/hadoop fs -put %s %s";
    private final static String HADOOP_MKDIR_COMMAND_NORMA ="%s/bin/hadoop fs -mkdir -p %s";

    /**
     * 提交命令，并将处理日志放入到session中
     */
    private static int submitCommand(HttpSession session, String sessionId, String command) {
        String hostName = ConstantParam.paramMap.get(ConstantParam.SSH_HOST_NAME);
        String userName = ConstantParam.paramMap.get(ConstantParam.SSH_USER_NAME);
        String password = ConstantParam.paramMap.get(ConstantParam.SSH_PASSWORD);
        try {
            if(session!=null){
                session.setAttribute(sessionId, null);
            }
            Connection conn = new Connection(hostName);
            conn.connect();
            boolean isAuthenticated = conn.authenticateWithPassword(userName, password);
            if (isAuthenticated == false) {
                throw new IOException("Authentication failed.");
            }

            Session sess = conn.openSession();
            sess.execCommand(command);

            System.out.println("be executing command : " + command);
            String systemType = ConstantParam.paramMap.get(ConstantParam.SPARK_SYSTEM_TYPE);
            InputStream stdout = null;
            if ("centos".equalsIgnoreCase(systemType)) {
                stdout = new StreamGobbler(sess.getStderr());
            } else {
                stdout = new StreamGobbler(sess.getStdout());
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(stdout, "UTF-8"));
            while (true) {
                String line = br.readLine();
                if (line == null) {
                    break;
                }
                if ("".equals(line.trim())) {
                    continue;
                }
                line = "<div><nobr>" + line.replace("\t", "　　　　") + "</nobr></div>";
                if (session != null) {
                    String info = (String) session.getAttribute(sessionId);
                    session.setAttribute(sessionId, ((info == null) ? "" : info) + line);
                }
                System.out.println(line);
            }
            br.close();
            if (session != null) {
                String info = (String) session.getAttribute(sessionId);
                session.setAttribute(sessionId, ((info == null) ? "" : info) + "<div>===================== END =====================</div>");
            }
            sess.waitForCondition(ChannelCondition.EXIT_STATUS, 60*60*1000);//默认等待一个小时的数据
            System.out.println("ExitCode: " + sess.getExitStatus());

            sess.close();
            conn.close();
            if(sess.getExitStatus()==null){
                return 1;
            }
            return sess.getExitStatus();
        } catch (IOException e) {
            e.printStackTrace(System.err);
            return 1;
        }
    }

    /**
     * 提交spark计算命令控制
     */
    public static int submitToCalculateEngine(HttpSession session, String sessionId, String entryClass, String param) {
        String sparkHome = ConstantParam.paramMap.get(ConstantParam.SPARK_HOME);
        String jarPath = ConstantParam.paramMap.get(ConstantParam.USER_TAG_ENGINE_JAR);

        String command = String.format(SPARK_COMMIT_COMMAND_NORMAL, sparkHome, entryClass, jarPath, param);
        return submitCommand(session, sessionId, command);
    }

    public static int submitToPutHadoop(HttpSession session,String source,String target){
        String hadoopHome = ConstantParam.paramMap.get(ConstantParam.HADOOP_HOME);
        String command = String.format(HADOOP_PUT_FILE_COMMAND_NORMA, hadoopHome, source,target);
        return submitCommand(session, SESSIONID_HADOOP_PUT, command);
    }

    public static int mkdirHadoopPath(HttpSession session,String path){
        String hadoopHome = ConstantParam.paramMap.get(ConstantParam.HADOOP_HOME);
        String command = String.format(HADOOP_MKDIR_COMMAND_NORMA, hadoopHome,path);
        return submitCommand(session, SESSIONID_HADOOP_PUT, command);
    }

    /**
     * 使用SQOOP从关系型数据库表中导入数据到HDFS
     * @param session : 当前session，传入目的用于存放日志
     * @param bean : 参数Map
     */
    public static int submitToImportFromRDB(HttpSession session, SqoopImportBean bean) {
        String sqoopHome = ConstantParam.paramMap.get(ConstantParam.SQOOP_HOME);
        String url = bean.getUrl();
        String un = bean.getDbUserName();
        String pw = bean.getDbPassword();
        String sql = bean.getSql();
        String sp = Constant.DATA_SPLIT.replace("\\", "\\\\");
        String sb = bean.getSplitBy();
        String dir = bean.getDir();
        int m = bean.getProcessCoreNum();
        String command = String.format(SQOOP_IMPORT_COMMAND_NORMAL, sqoopHome, url, un, pw, sql, sp, sb, dir, m);
        return submitCommand(session, SESSIONID_IMPORT_FROM_RDB, command);
    }

    public static int submitToSqoopFromSQL(HttpSession session, SqoopImportBean bean) {
        String sqoopHome = ConstantParam.paramMap.get(ConstantParam.SQOOP_HOME);
        String url = bean.getUrl();
        String un = bean.getDbUserName();
        String pw = bean.getDbPassword();
        String sql = bean.getSql();
        String sp = Constant.DATA_SPLIT.replace("\\", "\\\\");
        String sb = bean.getSplitBy();
        String dir = bean.getFolderName();
        int m = bean.getProcessCoreNum();
        String command = String.format(SQOOP_IMPORT_COMMAND_NORMAL, sqoopHome, url, un, pw, sql, sp, sb, dir, m);
        return submitCommand(session, SESSIONID_IMPORT_FROM_RDB, command);
    }
}
