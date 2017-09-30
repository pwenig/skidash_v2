angular.module('skidash')
.directive('forecast',['Mountain', function(Mountain) {

  return {
    restrict: 'E',
    scope: {},
    templateUrl: 'forecast.html',
    link: function ($scope, element, attributes) {

      Mountain.get().then(function(data) {
        
        $scope.mountains = data;
        $scope.display_forecast = false;
    
      });
        
      $scope.mountain_selected = function() {
    
        Mountain.get_forecast($scope.selected_mountain).then(function( response ) {
          
          $scope.forecast = response;
          $scope.mountain_image = $scope.selected_mountain['mtn_image1']
          $scope.current_forecast = response['conditions_response'];
          $scope.future_forecasts = response['forecast_response'];
          $scope.display_forecast = true;
    
        });
    
      };
     
    }
    
  }

}]);