package com.roy.hspersona.taglib;

import org.springframework.context.annotation.Bean;
import org.thymeleaf.dialect.AbstractProcessorDialect;
import org.thymeleaf.processor.IProcessor;
import org.thymeleaf.standard.StandardDialect;
import org.thymeleaf.standard.processor.StandardTextTagProcessor;
import org.thymeleaf.templatemode.TemplateMode;

import java.util.HashSet;
import java.util.Set;

/**
 * @author roy
 * @date 2021/11/30
 * @desc
 */
public class SysTagDialect extends AbstractProcessorDialect {
    private static final String NAME = "sys标签";
    private static final String PREFIX = "sys";

    public SysTagDialect() {
        super(NAME, PREFIX, StandardDialect.PROCESSOR_PRECEDENCE);
    }

    @Override
    public Set<IProcessor> getProcessors(String s) {
        final Set<IProcessor> processors=new HashSet<>();
        processors.add(new PermissionProcessor(PREFIX));
        processors.add(new OptionProcessor(PREFIX));
//        processors.add(new StandardTextTagProcessor(TemplateMode.HTML, PREFIX));
        return processors;
    }
}
