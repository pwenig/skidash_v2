angular.module('skidash')
.directive('travelalert', function() {
  
  return {
    restrict: 'E',
    scope: {alerts: '=', roads: '=', selectroad: '=', speeds: '='},
    templateUrl: 'travel_alert.html',
    link: function ($scope, element, attributes) {

      var speedwatch = $scope.$watch('speeds', function() {

        if($scope.speeds) {
          $scope.road_speeds = $scope.speeds;
          speedwatch();
        }

      });

      var alertwatch = $scope.$watch('alerts', function() {
        
        if( $scope.alerts) {
          $scope.alerts = $scope.alerts;
          alertwatch();
        }

      });

      $scope.selected_road = $scope.roads[0];

      $scope.showMessage = function() {
        
        $scope.displayMessage = !$scope.displayMessage;

      };

      $scope.selected = function() {

        $scope.selectroad($scope.selected_road);

      };


      $scope.checkspeed = function(speed) {
       
        if(  speed['AverageSpeed'] <= 55 && speed['AverageSpeed'] > 40  ) {
          return 'slow-segment slow-down'

        } else if( speed['AverageSpeed'] <= 40 ) {
          return 'slow-segment stopped'
        
        } else {
          return 'slow-segment'
        }
      }


    
    }

  
  }
    
});