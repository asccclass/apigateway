angular.module('PeopleControllers', [])
.controller('PersonManage', ['$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {

   // 取得個人資料
   $scope.DoreuserCourselist = function(sid) {
      $http({url: "https://www.justdrink.com.tw/weareparents/people", method:"GET" })
      .then(function successCallback(res) {
         if(res.data.errMsg) { alert("Data Error: " + res.data.errMsg); return false; }
      }, function errorCallback(data) { console.log(data); });
   };

   $scope.GetAssns = function() {
      $http({url: "/weareparents/assns", method:"GET" })
      .then(function successCallback(res) {
         if(res.data.errMsg) { alert("Data Error: " + res.data.errMsg); return false; }
console.log(res.data)
      }, function errorCallback(data) { console.log(data); });
   };

   $scope.init = function() {
      $scope.GetAssns();
   };
   // $scope.init();
}]);
