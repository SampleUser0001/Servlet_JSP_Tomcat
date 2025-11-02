<%@ page import ="ittimfn.sample.includejsp.enums.FormEnum" %>

<%
    for(FormEnum formEnum : FormEnum.getInitList()) {
%>
        <%= formEnum.getLabel() %>:
        <input 
            type="<%= formEnum.getType() %>" 
            id="<%= formEnum.name() %>" 
            name="<%= formEnum.name() %>" 
            value="<%=request.getAttribute(formEnum.name())%>"
            class="input mb-3" 
        />
<%
    }
%>