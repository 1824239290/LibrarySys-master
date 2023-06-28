<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>借阅时间线</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<ul class="layui-timeline">
    <c:forEach var="borrow" items="${borrowBook}">
        <li class="layui-timeline-item">+
            <div class="layui-timeline-content layui-text">
                <div class="layui-timeline-title">
                    <fmt:formatDate value="${borrow.borrowTime}" pattern="yyyy年MM月dd日HH点mm分ss秒" /> <br/>
                    <span style="color: red"> ${borrow.user.username}</span> 借走 <span style="color: crimson">${borrow.book.bookName}</span><br/>
                    <c:if test="${borrow.returnBookTime == null}">
                        未归还
                    </c:if>
                    <c:if test="${borrow.returnBookTime != null}">
                        <fmt:formatDate value="${borrow.returnBookTime}" pattern="yyyy年MM月dd日HH点mm分ss秒" /> <span style="color: green">归还</span>,
                    </c:if>
                </div>
            </div>
        </li>
    </c:forEach>
</ul>
<script src="${pageContext.request.contextPath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
</body>
</html>