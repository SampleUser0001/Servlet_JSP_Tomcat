<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="ittimfn.sample.includejsp.models.PulldownModel"
    import="ittimfn.sample.includejsp.models.PulldownOptionModel"
    import="ittimfn.sample.includejsp.enums.ApplicationCommonEnum"
%>
<%
    String key = (String) request.getParameter(ApplicationCommonEnum.PULLDOWN_KEY.getCode());
    PulldownModel pulldownModel = (PulldownModel) request.getAttribute(key);
    String onchangeFunc = request.getParameter("onchange");
%>
<div class="select">
  <select id="<%= pulldownModel.getId() %>" name="<%= pulldownModel.getId() %>" <%= onchangeFunc != null ? "onchange=\"" + onchangeFunc + "()\"" : "" %>>
    <% for (PulldownOptionModel option : pulldownModel.getOptions()) { %>
      <option value="<%= option.getValue() %>" <%= option.isSelected() ? "selected" : "" %>><%= option.getDisplayString() %></option>
    <% } %>
  </select>
</div>