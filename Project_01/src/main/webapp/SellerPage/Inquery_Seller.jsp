<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SellerMain</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.css">
<jsp:include page="/Common/LinkFile.jsp"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
<link href="https://unpkg.com/tabulator-tables/dist/css/tabulator.min.css" rel="stylesheet">
<link href="/resources/css/tabulator_site.css" rel="stylesheet">

<link rel="stylesheet" href="/resources/css/MainPage.css">
<script src="/resources/bootstrap/js/jquery-3.7.1.js"></script>
<script type="text/javascript" src="https://unpkg.com/tabulator-tables/dist/js/tabulator.min.js"></script>
<style>
.tabulator.tabulator-header
{
	border-bottom: 1px solid #3FB449;	
}
.tabulator-tableholder 
{
	border-right: 1px solid #f5f0f5;
	border-left: 1px solid #f5f0f5;
	/*background-color: #3f3f3f; /* 원하는 배경 색으로 변경 */
}

.table-controls
{
	margin-bottom: 0px;
    padding: 10px 5px 0 5px;
    background: #5f5f5f;
    border-bottom: 1px solid #ffffff;
    font-size: 14px;
}
.table-controls input, .table-controls select 
{
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    padding: 4px 10px;
    border: 1px solid #4b4b4b;
    border-radius: 5px;
    background: #1f1f1f;
    outline: none;
    color: #ccc;
}

.table-controls input, .table-controls select {
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    padding: 4px 10px;
    border: 1px solid #4b4b4b;
    border-radius: 5px;
    background: #1f1f1f;
    outline: none;
    color: #ccc;
}

.table-label {

	font-family: "Noto Sans KR", sans-serif;
	font-optical-sizing: auto;
	font-style: normal;
	
    display: inline-block;
    max-width: 100%;
    margin-bottom: 5px;
    font-weight: 700;
    color: #ccc;
}

.table-button {

	font-family: "Noto Sans KR", sans-serif;
	font-optical-sizing: auto;
	font-style: normal;
	
    padding: 5px 10px;
    border: 1px solid #25682a;
    background: #3FB449;
    background: -webkit-gradient(linear, left top, left bottom, from(#3FB449), to(#25682a));
    background: linear-gradient(to bottom, #3FB449 0%, #25682a 100%);
    color: #fff;
    font-weight: bold;
    -webkit-transition: color .3s, background .3s, opacity, .3s;
    transition: color .3s, background .3s, opacity, .3s;
    border-radius : 4px;
}
</style>
</head>
<body>
<jsp:include page="/Common/Header.jsp" />
<main>
<div class = "container" style = "max-width: 1050px; min-width: 1050px; padding-left: 0px; padding-right: 0px; padding-top: 40px;">
	<div class = "row" style = "border-bottom: 1px solid #efefef; padding-bottom: 20px;">
		<div class = "col-12" style="display: inline-flex;justify-content: center;">
			<label class = "sellerMainTitle">문의 내역</label>
		</div>
	</div>
</div>
<div class="container"
			style="max-width: 1050px; min-width: 1050px; padding-left: 0px; padding-right: 0px; padding-top: 40px;">
	<div class= "row d-flex flex-nowrap" style = "justify-content: space-between; padding-bottom: 0px;">
	<div class = "col">
		<div class="table-controls" style = "padding-top: 5px; padding-bottom: 5px;">
			<span style = "margin-right: 40px;">
				      <label class = "table-label">Field: </label>
				      <select id="filter-field">
				        <option></option>
				        <option value="name">Name</option>
				        <option value="progress">Progress</option>
				        <option value="gender">Gender</option>
				        <option value="rating">Rating</option>
				        <option value="col">Favourite Colour</option>
				        <option value="dob">Date Of Birth</option>
				        <option value="car">Drives</option>
				        <option value="function">Drives &amp; Rating &lt; 3</option>
				      </select>
			</span>
			<span style = "margin-right: 40px;">
				      <label class = "table-label">Type: </label>
				      <select id="filter-type">
				        <option value="=">=</option>
				        <option value="<">&lt;</option>
				        <option value="<=">&lt;=</option>
				        <option value=">">&gt;</option>
				        <option value=">=">&gt;=</option>
				        <option value="!=">!=</option>
				        <option value="like">like</option>
				      </select>
			</span>				
			<span style = "margin-right: 40px;">
				<label class = "table-label">Value: </label> 
				<input id="filter-value" type="text" placeholder="value to filter">
			</span>
			<button class = "table-button" id="filter-clear">Clear Filter</button>
		</div>
		</div>
	</div>			
</div>
<div class = "container" style = "max-width: 1050px; min-width: 1050px; padding-left: 0px; padding-right: 0px; padding-top: 0px;">
	<div class= "row d-flex flex-nowrap" style = "justify-content: space-between; padding-bottom: 40px; min-height: 200px;">
		<div class = "col-12">
			<div id="example-table" style = "border-bottom: 4px solid #163020;"></div>
		</div>
	</div>
</div>
<div style = "display: none;">
	<form id = "dataForm" name="data" method="post" action = "/SellerPage/SellerListDetail.jsp">
		<input id = "form_order_id" type="hidden" name ="order_id" value="">
		<input id = "form_name" type="hidden" name ="name" value="">
	</form>
</div>
</main>
	<div style = "display: none;">
		<form id = "dataForm" name="data" method="post" action = "/SellerPage/SellerListDetail.jsp">
			<input id = "form_order_id" type="hidden" name ="order_id" value="">
			<input id = "form_name" type="hidden" name ="name" value="">
		</form>
	</div>
<jsp:include page="/Common/Footer.jsp" />
<script type="text/javascript">
$(document).ready(function()
{
	var table = tabulatorInit();		
});

function tabulatorInit()
{
	var table = new Tabulator("#example-table", {
	    height:"430px",
	    layout: "fitColumns",
	    pagination: "local",          // 로컬 페이징 사용
	    paginationSize: 10,           // 페이지당 행 수
	    paginationSizeSelector: [5, 10, 20, 50], // 선택 가능한 페이지당 행 수
	    ajaxURL: "/SellerController/orderListTableData.func", // 데이터 로드할 URL
	    ajaxParams: { 
	        seller: 2
	    },
	    ajaxConfig: {
	        method: "GET"
	    },
	    columns:
	    [
		    {title:"주문번호", field:"order_id", sorter:"number"},
		    {title:"상품명", field:"name"},
		    {title:"상품수량", field:"product_cnt", hozAlign:"center"},		    
		    {title:"신청일자", field:"order_date", hozAlign:"center"},
		    {title:"지연상태", field:"rating", formatter:"traffic", hozAlign:"center", formatterParams:{ min:0,max:10,color:["green", "orange", "red"] }},	
	    ],
	    layout:"fitColumns"
	});
	    
	table.on("rowClick", function(e,row){
			//페이지 이동 처리 
		   console.log(row.getData());
			
		   	$('#form_order_id').val(row.getData().order_id);
	   		$("#form_name").val(row.getData().name);
			
		   $('#dataForm').submit();
		   //pageContext.forward("/SellerPage/SellerMainPage.jsp");
	    });
	    
	    return table;
}
		
		
</script>
</body>
</html>