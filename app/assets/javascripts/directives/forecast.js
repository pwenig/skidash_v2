angular.module('skidash')
.directive('forecast', function() {

  return {
    restrict: 'E',
    scope: {data: '='},
    templateUrl: 'forecast.html',
    link: function ($scope, element, attributes) {

      $scope.$watch('data', function() {
       
        $scope.current_forecast = $scope.data['conditions_response'];
        $scope.future_forecasts = $scope.data['forecast_response'];

      });
     


    }
    
  }


});