package com.roy.hspersona.web.anno;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author roy
 * @date 2021/12/16
 * @desc 用于构架展现中心需要展现的字段与模型的对应关系。
 */
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
public @interface TagElement {
    String value();
    //结果格式化方法。对应FormatService中的方法。
    String formatMethod() default "";
}
