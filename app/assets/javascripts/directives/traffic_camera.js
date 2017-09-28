angular.module('skidash')
.directive('travelcamera', function() {
  
  return {
    restrict: 'E',
    scope: {images: '='},
    templateUrl: 'traffic_camera.html',
    link: function ($scope, element, attributes) {

      var imagewatch = $scope.$watch('images', function() {

        if($scope.images) {

          $scope.images = $scope.images;
          imagewatch();

        }
        
       });

     


    }

  
  }
    
});