app.controller('MountainCtrl', ['$scope', 'Mountain', function($scope, Mountain) {

  Mountain.get().then(function(data) {

    $scope.mountains = data;

  });

  $scope.selected = function() {
    
    Mountain.get_forecast($scope.selected_mountain);

  };


}]);



