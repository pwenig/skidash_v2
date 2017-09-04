app.directive('travelalert', function() {
  
  return {
    restrict: 'E',
    scope: {alerts: '=', roads: '=', selectroad: '='},
    templateUrl: 'travel_alert.html',
    link: function ($scope, element, attributes) {

      $scope.selected_road = $scope.roads[0];

      $scope.showMessage = function() {
        
        $scope.displayMessage = !$scope.displayMessage;

      };

      $scope.selected = function() {

        $scope.selectroad($scope.selected_road);

      };


    
    }

  
  }
    
});