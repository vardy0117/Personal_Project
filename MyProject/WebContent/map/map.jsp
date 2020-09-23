<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>동물미용</title>

</head>
<body>

<jsp:include page="../include/header.jsp"/>
<h2 style="text-align: center;">찾아 오는 길</h2>
<div id="map" style="width:70%;height:350px; margin: 20px auto;" ></div>
      <link href=../css/boardStyle.css rel="stylesheet" type="text/css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1c1f1848db7c6b4c9de4be7a168d19d8"></script>
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11f0946c05fcdb21e135f4e033b1b4b6"></script> -->
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(35.158472648198, 129.06199616550578), // 지도의 중심좌표
        level: 2 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

var imageSrc = '../img/flag.svg', // 마커이미지의 주소입니다    
    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
      
// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
    markerPosition = new kakao.maps.LatLng(35.158472648198, 129.06199616550578); // 마커가 표시될 위치입니다

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition, 
    image: markerImage // 마커이미지 설정 
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);  
</script>
<small style="text-align: center;display: block;">
	부산광역시 부산진구 동천로 109 삼한골든게이트 7층 6강의장<br>
	(도보4분) 1,2호선 서면역 8번 출구 / 1호선 부전역 2번 출구

</small>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>