<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    body {
        font-family: Arial, sans-serif;
        max-width: 1000px;
        margin: 0 auto;
        padding: 20px;
        background-color: #f5f5f5;
    }
    h1 {
        color: #333;
        border-bottom: 3px solid #4CAF50;
        padding-bottom: 10px;
    }
    .search-form {
        background-color: white;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .search-form label {
        display: inline-block;
        width: 120px;
        font-weight: bold;
    }
    .search-form input[type="text"],
    .search-form select {
        padding: 8px;
        width: 300px;
        border: 1px solid #ddd;
        border-radius: 4px;
        margin-bottom: 10px;
    }
    .search-form button {
        background-color: #4CAF50;
        color: white;
        padding: 10px 30px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        margin-left: 120px;
    }
    .search-form button:hover {
        background-color: #45a049;
    }
    .results {
        background-color: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .result-count {
        color: #666;
        margin-bottom: 15px;
        font-size: 14px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th {
        background-color: #4CAF50;
        color: white;
        padding: 12px;
        text-align: left;
    }
    td {
        padding: 10px;
        border-bottom: 1px solid #ddd;
    }
    tr:hover {
        background-color: #f5f5f5;
    }
    a {
        color: #4CAF50;
        text-decoration: none;
        font-weight: bold;
    }
    a:hover {
        text-decoration: underline;
    }
    .no-results {
        text-align: center;
        color: #999;
        padding: 30px;
    }
    .detail-container {
        background-color: #fafafa;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        border: 1px solid #e0e0e0;
    }
    .book-header {
        text-align: center;
        padding: 15px;
        background-color: #f0f0f0;
        border-radius: 6px;
        margin-bottom: 20px;
    }
    .book-title {
        font-size: 22px;
        color: #333;
        margin: 8px 0;
        font-weight: bold;
    }
    .book-id {
        color: #999;
        font-size: 13px;
    }
    .detail-row {
        margin-bottom: 15px;
        padding: 12px;
        background-color: white;
        border-radius: 4px;
        border-left: 3px solid #4CAF50;
    }
    .detail-label {
        font-weight: bold;
        color: #4CAF50;
        display: inline-block;
        width: 120px;
        font-size: 14px;
    }
    .detail-value {
        font-size: 16px;
        color: #333;
    }
    .btn-new {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 4px;
        font-weight: bold;
    }
    .btn-new:hover {
        background-color: #45a049;
    }
</style>
