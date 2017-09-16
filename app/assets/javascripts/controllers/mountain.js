angular.module('skidash')
.controller('MountainCtrl', MountainCtrl);

MountainCtrl.$inject = ['$scope', 'Mountain', 'Road'];

function MountainCtrl ($scope, Mountain, Road) {

  $scope.show_volume = true;

  Mountain.get().then(function(data) {

    $scope.mountains = data;
    $scope.display_forecast = false;

  });

  Road.get().then(function(data) {

    $scope.roads = data;
    road_default = $scope.roads[0];
    $scope.get_alerts(road_default);
    $scope.get_images(road_default);
    $scope.get_speeds(road_default);

  });
  
  $scope.selected = function() {

    Mountain.get_forecast($scope.selected_mountain).then(function( response ) {
      
      $scope.forecast = response;
      $scope.display_forecast = true;

    });

  };

  $scope.roadSelected = function(road) {
    if(road['name'] == 'I-70') {
      $scope.show_volume = true;
    } else {
      $scope.show_volume = false;
    }
    $scope.get_alerts(road);
    $scope.get_images(road);

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

  $scope.get_speeds = function(road) {

    Road.get_traffic_speeds(road).then(function(data) {

      $scope.road_speeds = data;

    });

  };


}



