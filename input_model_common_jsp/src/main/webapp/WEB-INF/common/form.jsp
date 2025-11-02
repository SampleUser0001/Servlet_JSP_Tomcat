<%@ page import ="ittimfn.sample.includejsp.enums.FormEnum" %>
<%@ page import ="java.util.List" %>

<%
    String formMode = (String) request.getAttribute("formMode");
    List<FormEnum> formList;
    if ("update".equals(formMode)) {
        formList = FormEnum.getUpdateList();
    } else {
        formList = FormEnum.getInitList();
    }

    for(FormEnum formEnum : formList) {
%>
        <%= formEnum.getLabel() %>:
        <input
            type="<%= formEnum.getType() %>"
            id="<%= formEnum.name() %>"
            name="<%= formEnum.name() %>"
            value="<%=request.getAttribute(formEnum.name())%>"
            class="input mb-3"
            <%= formEnum.getReadonly() %>
        />
<%
    }
%>