angular.module('skidash')
.directive('forecast', function() {

  return {
    restrict: 'E',
    scope: {data: '=', mountain: '='},
    templateUrl: 'forecast.html',
    link: function ($scope, element, attributes) {

     var datawatch = $scope.$watch('data', function() {
       if( $scope.data ) {
        $scope.current_forecast = $scope.data['conditions_response'];
        $scope.future_forecasts = $scope.data['forecast_response'];
       }
       

      });

      var mountainwatch = $scope.$watch('mountain', function() {
        if( $scope.mountain ) {
          $scope.mountain_image = $scope.mountain['mtn_image1']
        }
        
      })
     


    }
    
  }


});