import com.roy.personaeng.util.ComUtil;
import org.apache.spark.SparkConf;
import org.apache.spark.SparkContext;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.sql.SparkSession;

/**
 * @author roy
 * @date 2021/12/14
 * @desc
 */
public class TestJob {

    public static void main(String[] args) {
        ComUtil.initParams();
        SparkConf conf = ComUtil.getSparkConfig("TestJob");
        conf.setMaster("local[*]");
        SparkSession sparkSession = SparkSession.builder().config(conf).getOrCreate();
        SparkContext sparkContext = sparkSession.sparkContext();
        String filePath = "hdfs://hadoop01/data/admin/hspersona/DS/";
        JavaRDD<String> lines = sparkSession.read().textFile(filePath).toJavaRDD();
        lines.map(line -> {
            System.out.println(line);
            return null;
        }).collect();
        sparkSession.stop();
    }
}
