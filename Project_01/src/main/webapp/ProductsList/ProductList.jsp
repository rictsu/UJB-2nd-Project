<%@page import="ProductsListController.CategoryMap"%>
<%@page import="ProductsListController.ChildCategoryMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="Category.CategoryDTO"%>
<%@page import="ProductsListController.ListDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
    int currentPage = (Integer) request.getAttribute("currentPage");
    String category = request.getParameter("category");
    int totalPages = (Integer) request.getAttribute("totalPages");
    String[] filters = request.getParameterValues("filters");
    String price = request.getParameter("price");
    String[] delivery = request.getParameterValues("delivery");

    // 현재 페이지가 0 이하이면 1페이지로 설정
    if (currentPage <= 0) {
        currentPage = 1;
    }

    // 카테고리가 null일 경우 기본값 "all"로 설정
    if (category == null) {
        category = "all";
    }
    
	
	
	if (price == null) {
		price = "";
	}
	 // 필터와 딜리버리 값을 문자열로 합치는 로직
    String filtersStr = "";
    if (filters != null && filters.length > 0) {
        filtersStr = String.join("%", filters); // 배열을 "%"로 구분하여 문자열로 합침
    }

    String deliveryStr = "";
    if (delivery != null && delivery.length > 0) {
        deliveryStr = String.join("%", delivery); // 배열을 "%"로 구분하여 문자열로 합침
    }
	

    int startPage = Math.max(1, currentPage - 2);
    int endPage = Math.min(totalPages, startPage + 4);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마켓 신상품 - 그린</title>

<!-- Bootstrap CSS 로드 -->
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.css">

<!-- 개발에 필요한 LinkFile 공용 목적(Font 등을 로드) -->
<jsp:include page="/Common/LinkFile.jsp" />

<!-- Head, Footer CSS 링크 필수 -->
<link rel="stylesheet" href="/resources/css/Common.css">
<link rel="stylesheet" href="/resources/css/ProductList.css?after">

<!-- jQuery 사용을 위한 JS 로드 -->
<script src="/resources/bootstrap/js/jquery-3.7.1.js"></script>
</head>
<body>
	<jsp:include page="/Common/Header.jsp" />
	<div class="listbody">
		<div class="container mt-5">
			<h3 class="text-center listheader">상품 목록</h3>
			
			<ul class="justify-content-center itemnav">
			<li class="item" id="item"><a class="link" href="<%=request.getContextPath()%>/ProductsList/ProductList.do?page=1&category=all&filters=&price=&delivery=" data-category="all">전체 상품</a></li>
			<% 
				Map<String, String> cateMap = CategoryMap.getCateMap();
				
				List<CategoryDTO> cate = (List<CategoryDTO>) request.getAttribute("cate"); 
				if(cate != null){
					for(CategoryDTO dto : cate){
					String CateName = dto.getCategory_Name();
					String englishCateName = cateMap.getOrDefault(CateName, CateName);
			%>
				<li class="item"><a class="link" href="<%=request.getContextPath()%>/ProductsList/ProductList.do?page=1&category=<%= englishCateName %>&filters=&price=&delivery=" data-category="<%= englishCateName %>"><%= dto.getCategory_Name() %></a></li>
				<%}
					} %>
			</ul>
		</div>
		<div class="listcontainer">
			<div class="maincontent">
				<div class="sticky-sidebar">
					<div class="sidebar-title">
						<span class="titlespan">필터</span>
					</div>
					<div class="sticky-menu">
						<form id="filterForm" method="GET" action="<%= request.getContextPath() %>/ProductsList/ProductList.do" accept-charset="utf-8">
							<div class="filter-group">
								<div class="toggle-btn">
									<h5 class="title">카테고리</h5>
									<span class="arrow">▲</span>
								</div>
								<div class="filter-content" id="categoryFilters">
									<div>
										<input type="checkbox" id="category1" name="filters"
											value="new" > <label for="category1">인기신상랭킹</label>
									</div>
									<% 
										Map<String, String> childmap = ChildCategoryMap.getChildMap();
										List<CategoryDTO> Childcate = (List<CategoryDTO>) request.getAttribute("Childcate");
										if(Childcate != null){
											int i = 2;
											for(CategoryDTO cdto : Childcate){
											String ChildcategoryName = cdto.getCategory_Name();
											String engName = childmap.getOrDefault(ChildcategoryName, ChildcategoryName);
											%>
									<div>
										<input type="checkbox" id="category<%=i%>" name="filters"
											value="<%=engName %>" > <label for="category<%=i%>"><%=cdto.getCategory_Name() %></label>
									</div>
									<%
										i++;
										}
											}%>	
								</div>
							</div>
							<div class="filter-group">
								<div class="toggle-btn">
									<h5 class="title">가격</h5>
									<span class="arrow">▲</span>
								</div>
								<div class="filter-content" id="price-filter">
									<div>
										<input type="radio" id="price1" name="price" value="8499">
										<label for="price1">8,500원 미만</label>
									</div>
									<div>
										<input type="radio" id="price2" name="price"
											value="15999"> <label for="price2">8,500원
											~ 16,900원</label>
									</div>
									<div>
										<input type="radio" id="price3" name="price"
											value="34999"> <label for="price3">16,900원
											~ 35,000원</label>
									</div>
									<div>
										<input type="radio" id="price4" name="price" value="35000">
										<label for="price4">35,000원 이상</label>
									</div>
								</div>
								<div class="filter-group" id="delivery-filter">
									<div class="toggle-btn">
										<h5 class="title">배송</h5>
										<span class="arrow">▲</span>
									</div>
									<div class="filter-content">
										<div>
											<input type="checkbox" id="morning" name="delivery"
												value="morning"> <label for="morning">샛별배송</label>
										</div>
										<div>
											<input type="checkbox" id="nomal" name="delivery"
												value="nomal"> <label for="nomal">판매자배송</label>
										</div>
									</div>
								</div>
							</div>
							<div class="filter-group">
								<button type="submit" class="btn btn-primary">적용</button>
							</div>
						</form>
					</div>
				</div>
				<div class="products">
					<div class="productsortcontainer">
						<div class="productscnt" id="productcnt">
							총
							<%=request.getAttribute("cnt")%>건
						</div>
						<ul class="productsort">
							<li class="sort-li"><a href="#" class="sort-a" id="">추천순</a></li>
							<li class="sort-li"><a href="#" class="sort-a">신상품순</a></li>
							<li class="sort-li"><a href="#" class="sort-a">판매량순</a></li>
							<li class="sort-li"><a href="#" class="sort-a">혜택순</a></li>
							<li class="sort-li"><a href="#" class="sort-a">낮은 가격순</a></li>
							<li class="sort-li"><a href="#" class="sort-a">높은 가격순</a></li>
						</ul>
					</div>
					<div class="container list" id="productList" style="text-decoration-line: none;">
						<%
						List<ListDTO> list = (List<ListDTO>) request.getAttribute("list");
						if (list != null) {
							for (ListDTO dto : list) {
						%>
						<div class="row">
							<a href="#" style="text-decoration-line: none;"> <img
								src="https://product-image.kurly.com/hdims/resize/%5E%3E360x%3E468/cropcenter/360x468/quality/85/src/product/image/b15f2d12-eca6-4491-b37e-83d156377cde.jpg?v=0531"
								style="padding: 0px; width: 249px; height: 320px; border-radius: 2%; overflow: hidden;">
								<button class="btn btn-navy rounded-1 fontCommon_Option"
									type="button"
									style="width: 249px; height: 36px; margin-top: 5px;">구매</button>
								<div class="delivery" style="text-align: left; margin-top: 5px;"><%=dto.getDelivery()%></div>
								<div class="list_Itemtitle"
									style="width: 249px; text-align: left;"><%=dto.getTitle()%></div>
								<div class="row" style="margin-top: 5px;">
									<div class="explation" style="text-align: left;"><%=dto.getContent()%></div>
									<div class="col-12">
										<span class="OripriceText" style="width: 249px;"><%=dto.getOprice()%>원</span>
									</div>
								</div>
								<div class="row" style="margin-top: 5px;">
									<div class="col-2" style="display: inline-flex;">
										<span class="SalePercentText" style="text-align: left"><%=dto.getSaleper()%>%</span>
									</div>
									<div class="col" style="display: inline-flex;">
										<span class="SalePriceText" style="text-align: left"><%=dto.getNprice()%>원</span>
									</div>
								</div>
							</a>
						</div>
						<%
						}
						}
						%>

					</div>



				</div>
			</div>
			<div class="pagebtn">
    <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-center">
        	<li class="page-item">
        		
                <a class="page-link" href="<%= request.getContextPath() %>/ProductsList/ProductList.do?page=<%= 1 %>&category=<%=category %>&filters=<%=filtersStr %>&price=<%=price %>&delivery=<%=deliveryStr %>" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="<%= request.getContextPath() %>/ProductsList/ProductList.do?page=<%= Math.max(1, currentPage - 1) %>&category=<%=category %>&filters=<%=filtersStr %>&price=<%=price %>&delivery=<%=deliveryStr %>" aria-label="Previous">
                    <span aria-hidden="true"><</span>
                </a>
            </li>
            <%  

            if (startPage <= 1) {
                endPage = Math.min(totalPages, 5);
            }
            
            for (int i = startPage; i <= endPage; i++) {
                String activeClass = (currentPage == i) ? "active" : "";
            %>
            <li class="page-item <%= activeClass %>">
                <a class="page-link" href="<%= request.getContextPath() %>/ProductsList/ProductList.do?page=<%= i %>&category=<%=category %>&filters=<%=filtersStr %>&price=<%=price %>&delivery=<%=deliveryStr %>"><%= i %></a>
            </li>
            <% } %>
            <li class="page-item">
                <a class="page-link" href="<%= request.getContextPath() %>/ProductsList/ProductList.do?page=<%= Math.min(totalPages, currentPage + 1) %>&category=<%=category %>&filters=<%=filtersStr %>&price=<%=price %>&delivery=<%=deliveryStr %>" aria-label="Next">
                    <span aria-hidden="true">></span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="<%= request.getContextPath() %>/ProductsList/ProductList.do?page=<%= totalPages %>&category=<%=category %>&filters=<%=filtersStr %>&price=<%=price %>&delivery=<%=deliveryStr %>" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>
</div>
		</div>

	</div>
	<jsp:include page="/Common/Footer.jsp" />
<script>
    $(document).ready(function() {
        let currentPage = '<%= currentPage %>';
        let category = '<%= category %>';
        let filters = '<%= filtersStr %>';
        let price = '<%= price %>';
        let delivery = '<%= deliveryStr %>';
        let selectedFilters = getParameterByName('filters') ? getParameterByName('filters').split(',') : [];
        let selectedPrice = getParameterByName('price');
        let selectedDelivery = getParameterByName('delivery') ? getParameterByName('delivery').split(',') : [];
        
        updateFilterState(selectedFilters, selectedPrice, selectedDelivery);
        
        
        function getParameterByName(name, url = window.location.href) {
            name = name.replace(/[\[\]]/g, '\\$&');
            let regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)');
            let results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, ' '));
        }
       
        // 초기 이벤트 핸들러 설정
        function initializeEventHandlers() {
            console.log("이벤트 핸들러 초기화");

            // 토글 버튼 클릭 이벤트 핸들러
            $('.toggle-btn').off('click').on('click', function() {
                let $arrow = $(this).find('.arrow');
                let $filterContent = $(this).next('.filter-content');

                $filterContent.stop().slideToggle(50, function() {
                    if ($filterContent.is(':visible')) {
                        $arrow.text('▲');
                    } else {
                        $arrow.text('▼');
                    }
                });
            });

            // 라디오 버튼 클릭 이벤트 핸들러
            let beforeChecked = null;
            $("input[type='radio'][name='price']").off('click').on("click", function() {
                let isChecked = $(this).prop("checked");
                if (isChecked && this !== beforeChecked) {
                    beforeChecked = this;
                } else if (isChecked && this === beforeChecked) {
                    $(this).prop("checked", false);
                    beforeChecked = null;
                }
            });
			
            
        }
       

        // 네비게이션 링크 스타일링 함수
        function updateNavigationStyle(currentCategory) {
            console.log("스타일 적용");
            $('.itemnav .link').each(function() {
                let clickedCategory = $(this).data('category') || "all"; // 클릭된 카테고리 가져오기

                if (clickedCategory == currentCategory) {
                    $(this).css({
                        'color': 'green',
                        'font-weight': 'bold'
                    });
                } else {
                    $(this).css({
                        'color': '',
                        'font-weight': ''
                    });
                }
            });
        }

        // 초기 URL 설정 및 스타일 적용
        updateNavigationStyle(category);
        let initialUrl = window.location.origin + '/ProductsList/ProductList.do?page=' + currentPage + '&category=' + category + '&filters=' + filters + '&price=' + price + '&delivery=' + delivery;
        history.replaceState({ page: currentPage, category: category, filters: filters, price: price, delivery: delivery }, null, initialUrl);
        updateNavigationStyle(category);
        
     // 다음 버튼 클릭 이벤트 핸들러
        $('.itemnav .link .pagination').off('click').on('click', function(event) {
            event.preventDefault();
            let clickedCategory = $(this).data('category');

           

            // handleFilterFormSubmit 함수 호출
            handleFilterFormSubmit(clickedCategory, selectedFilters, selectedPrice, selectedDelivery);
        });

     // 필터 폼 제출 이벤트 핸들러
        $('#filterForm').submit(function(event) {
            event.preventDefault();
			page = 1;
			
            // 현재 선택된 필터, 가격, 배송 옵션 가져오기
            let selectedFilters = [];
            $('input[name="filters"]:checked').each(function() {
                selectedFilters.push($(this).val());
            });

            let selectedPrice = $('input[name="price"]:checked').val();
            let selectedDelivery = $('input[name="delivery"]:checked').map(function() {
                return $(this).val();
            }).get();

            // handleFilterFormSubmit 함수 호출
            handleFilterFormSubmit(category, selectedFilters, selectedPrice, selectedDelivery);
           
            // 필터링된 결과를 반영한 콘텐츠에 이벤트 핸들러 재설정
            initializeEventHandlers();
        });

        function handleFilterFormSubmit(clickedCategory, selectedFilters, selectedPrice, selectedDelivery) {
            // 가격이 undefined인 경우 빈 문자열로 처리
            let priceParam = selectedPrice !== undefined ? '&price=' + selectedPrice : '';

            $.ajax({
                type: 'GET',
                url: window.location.origin + '/ProductsList/ProductList.do',
                data: {
                    page: 1,
                    category: clickedCategory,
                    filters: selectedFilters.join(','),
                    price: selectedPrice,
                    delivery: selectedDelivery.join(',')
                },
                success: function(data) {
                    console.log("AJAX 요청 성공");
                    let productListHtml = $(data).find('#productList').html();
                    let productcntHtml = $(data).find('#productcnt').html();
                    let itemhtml = $(data).find('#item').html();
                    let categoryFiltersHtml = $(data).find('#categoryFilters').html();
			
                    // 제품 목록과 개수 업데이트
                    $('#productList').html(productListHtml);
                    $('#productcnt').html(productcntHtml);
                    $('#item').html(itemhtml);
                    $('#categoryFilters').html(categoryFiltersHtml);
                    
                    updateFilterState(selectedFilters, selectedPrice, selectedDelivery);

                    // 브라우저 URL 업데이트하여 현재 상태 반영
                    let newUrl = window.location.origin + '/ProductsList/ProductList.do?page=1'
                                 + '&category=' + clickedCategory
                                 + '&filters=' + encodeURIComponent(selectedFilters.join(','))
                                 + priceParam
                                 + '&delivery=' + encodeURIComponent(selectedDelivery.join(','));
                    history.pushState({ page: 1, category: clickedCategory, filters: selectedFilters, price: selectedPrice, delivery: selectedDelivery }, null, newUrl);
					
                    // 필터링된 결과를 반영한 콘텐츠에 이벤트 핸들러 재설정
                    initializeEventHandlers();
                    updateNavigationStyle(clickedCategory);
                    retainFilterState(selectedFilters, selectedPrice, selectedDelivery);
                    document.location.reload();
                },
                error: function(xhr, status, error) {
                    console.error("AJAX 요청 실패", status, error);
                }
            });
        }
     
        // 필터 상태 유지 함수
        function retainFilterState(selectedFilters, selectedPrice, selectedDelivery) {
            // 필터 체크박스 상태 유지
            $('input[name="filters"]').each(function() {
                if (selectedFilters.includes($(this).val())) {
                    $(this).prop('checked', true);
                } else {
                    $(this).prop('checked', false);
                }
            });

            // 가격 라디오 버튼 상태 유지
            $('input[name="price"]').each(function() {
                if ($(this).val() === selectedPrice) {
                    $(this).prop('checked', true);
                } else {
                    $(this).prop('checked', false);
                }
            });

            // 배송 옵션 체크박스 상태 유지
            $('input[name="delivery"]').each(function() {
                if (selectedDelivery.includes($(this).val())) {
                    $(this).prop('checked', true);
                } else {
                    $(this).prop('checked', false);
                }
            });
        }
        
        function updateFilterState(selectedFilters, selectedPrice, selectedDelivery) {
            // 모든 필터 체크박스 초기화
            $('input[name="filters"]').prop('checked', false);

            // 선택된 필터에 해당하는 체크박스 체크
            selectedFilters.forEach(function(filter) {
                $('input[name="filters"][value="' + filter + '"]').prop('checked', true);
            });

            // 가격 라디오 버튼 선택
            if (selectedPrice) {
                $('input[name="price"]').prop('checked', false); // 모든 가격 라디오 버튼 초기화
                $('input[name="price"][value="' + selectedPrice + '"]').prop('checked', true); // 선택된 가격 라디오 버튼 체크
            }

            // 선택된 배송 옵션 체크박스 선택
            $('input[name="delivery"]').prop('checked', false); // 모든 배송 옵션 체크박스 초기화
            selectedDelivery.forEach(function(deliveryOption) {
                $('input[name="delivery"][value="' + deliveryOption + '"]').prop('checked', true);
            });
        }

       
        // 초기 이벤트 핸들러 설정 호출
        initializeEventHandlers();
    });
</script>

</body>
</html>
