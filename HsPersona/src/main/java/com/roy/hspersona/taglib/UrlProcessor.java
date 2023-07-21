package com.roy.hspersona.taglib;

import org.thymeleaf.context.ITemplateContext;
import org.thymeleaf.model.IModel;
import org.thymeleaf.model.IModelFactory;
import org.thymeleaf.model.IProcessableElementTag;
import org.thymeleaf.processor.element.AbstractElementTagProcessor;
import org.thymeleaf.processor.element.IElementTagStructureHandler;
import org.thymeleaf.templatemode.TemplateMode;

/**
 * @author roy
 * @date 2021/11/30
 * @desc
 */
public class UrlProcessor extends AbstractElementTagProcessor {
    private static final String COMMAND_NAME="url";
    private static final int PRECEDENCE = 10000;

    public UrlProcessor(String dialectPrefix) {
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
        final String url = iProcessableElementTag.getAttributeValue("url");
        IModelFactory modelFactory = iTemplateContext.getModelFactory();
        IModel model = modelFactory.createModel();
        model.add(modelFactory.createOpenElementTag("h1"));
        model.add(modelFactory.createText(url));
        model.add(modelFactory.createCloseElementTag("h1"));
        iElementTagStructureHandler.replaceWith(model,false);
//        iElementTagStructureHandler.removeElement();
    }
}
