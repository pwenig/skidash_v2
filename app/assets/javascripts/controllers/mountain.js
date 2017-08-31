app.controller('MountainCtrl', ['$scope', 'Mountain', function($scope, Mountain) {

  Mountain.get().then(function(data) {

    $scope.mountains = data;
    $scope.display_forecast = false;

  });

  Mountain.get_traffic_alerts().then(function(data) {

    $scope.traffic_alerts = data;

  });

  $scope.selected = function() {

    Mountain.get_forecast($scope.selected_mountain).then(function( response ) {
      
      $scope.forecast = response;
      $scope.display_forecast = true;

    });

  };


}]);



