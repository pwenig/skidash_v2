app.directive('travelalert', function() {
  
  return {
    restrict: 'E',
    scope: {alerts: '='},
    templateUrl: 'travel_alert.html',
    link: function ($scope, element, attributes) {

      $scope.showMessage = function() {
        
        $scope.displayMessage = !$scope.displayMessage;

      }

    }

  
  }
    
});