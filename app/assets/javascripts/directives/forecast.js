angular.module('skidash')
.directive('forecast', function() {

  return {
    restrict: 'E',
    scope: {data: '=', mountain: '='},
    templateUrl: 'forecast.html',
    link: function ($scope, element, attributes) {

      $scope.$watch('data', function() {
       
        $scope.current_forecast = $scope.data['conditions_response'];
        $scope.future_forecasts = $scope.data['forecast_response'];

      });

      $scope.$watch('mountain', function() {
        
        $scope.mountain_image = $scope.mountain['mtn_image1']
        
      })
     


    }
    
  }


});