<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="ittimfn.sample.includejsp.models.PulldownModel"
    import="ittimfn.sample.includejsp.enums.ApplicationCommonEnum"
%>
<%
    String key = (String) request.getParameter(ApplicationCommonEnum.PULLDOWN_KEY.getCode());
    PulldownModel pulldownModel = (PulldownModel) request.getAttribute("pulldown." + key);
    String onchangeFunc = request.getParameter("onchange");
%>
<div class="select">
  <select id="<%= pulldownModel.getId() %>" name="<%= pulldownModel.getId() %>" <%= onchangeFunc != null ? "onchange=\"" + onchangeFunc + "()\"" : "" %>>
    <%= pulldownModel.buildOptionsHtml() %>
  </select>
</div>
