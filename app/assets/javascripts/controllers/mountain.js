app.controller('MountainCtrl', ['$scope', 'Mountain', 'Road', function($scope, Mountain, Road) {

  Mountain.get().then(function(data) {

    $scope.mountains = data;
    $scope.display_forecast = false;

  });

  Road.get().then(function(data) {

    $scope.roads = data;
    road_default = $scope.roads[0];
    $scope.get_alerts(road_default);
    $scope.get_images(road_default);

  });
  
  $scope.selected = function() {

    Mountain.get_forecast($scope.selected_mountain).then(function( response ) {
      
      $scope.forecast = response;
      $scope.display_forecast = true;

    });

  };

  $scope.roadSelected = function(road) {
   
    $scope.get_alerts(road);
    $scope.get_images(road);

  };

  $scope.get_alerts = function(road) {

    Mountain.get_traffic_alerts(road).then(function(data) {
      
      $scope.traffic_alerts = data;
  
    });


  };

  $scope.get_images = function(road) {

    Mountain.get_traffic_images(road).then(function(data) {
      
      $scope.traffic_images = data
  
    });

  };


}]);



