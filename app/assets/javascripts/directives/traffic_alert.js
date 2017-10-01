angular.module('skidash')
.directive('travelalert',[ 'Road', function(Road) {
  
  return {
    restrict: 'E',
    scope: {},
    templateUrl: 'travel_alert.html',
    link: function ($scope, element, attributes) {

      $scope.get_speeds = function(road) {
      
        Road.get_traffic_speeds(road).then(function(data) {
    
          $scope.road_speeds = data;
          console.log('SPEEDS', $scope.road_speeds)
    
        });
      };

      $scope.get_alerts = function(road) {
       
        Road.get_traffic_alerts(road).then(function(data) {
          
          $scope.traffic_alerts = data;
      
        });
      };

      $scope.get_images = function(road) {
        
        Road.get_traffic_images(road).then(function(data) {
          
          $scope.traffic_images = data;
      
        });
      };

      Road.get().then(function(data) {
        
        $scope.roads = data;
        $scope.road_default = $scope.roads[0];
        $scope.selected_road = $scope.road_default;
        $scope.get_alerts($scope.road_default);
        $scope.get_images($scope.road_default);
        $scope.get_speeds($scope.road_default);
    
      });

      $scope.road_selected = function() {
        
        if($scope.selected_road['name'] == 'I-70') {
          $scope.show_volume = true;
        } else {
          $scope.show_volume = false;
        }
        $scope.get_alerts($scope.selected_road);
        $scope.get_images($scope.selected_road);

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
    
}]);