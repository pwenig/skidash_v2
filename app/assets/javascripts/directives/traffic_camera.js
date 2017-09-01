app.directive('travelcamera', function() {
  
  return {
    restrict: 'E',
    scope: {images: '='},
    templateUrl: 'traffic_camera.html',
    link: function ($scope, element, attributes) {

      $scope.$watch('images', function() {
        if($scope.images && $scope.images.length > 0) {

          $scope.first_set = $scope.images.slice(0, 6);
          $scope.second_set = $scope.images.slice(6, 12);
        }
        
       });

     


    }

  
  }
    
});