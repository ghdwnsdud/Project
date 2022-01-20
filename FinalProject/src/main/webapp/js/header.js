  //카카오로그아웃  
Kakao.init('b11084e50bf68f8f2d2794bd32141396'); //발급받은 키 중 javascript키를 사용해준다.
      function kakaoLogout() {
          if (Kakao.Auth.getAccessToken()) {
            Kakao.API.request({
              url: '/v1/user/unlink',
              success: function (response) {
              	alert("로그아웃 완료 !");
              	location.href = 'easylogout'
              },
              fail: function (error) {
                console.log(error)
              },
            })
            Kakao.Auth.setAccessToken(undefined)
          }
        }  