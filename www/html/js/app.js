angular.module('Assns', [
   "ngRoute",
   "AssnsControllers",
   "PeopleControllers"
])
.config(function($routeProvider) {
   $routeProvider
      .when('/', { controller:'AssnsManage', templateUrl: 'views/assns.html'})
      .when('/people/:id', { controller:'PersonManage', templateUrl: 'views/people.html'})
      .otherwise({ redirectTo: '/' });
});
