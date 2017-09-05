angular.module('skidash')
.directive('travelcamera', function() {
  
  return {
    restrict: 'E',
    scope: {images: '='},
    templateUrl: 'traffic_camera.html',
    link: function ($scope, element, attributes) {

      $scope.$watch('images', function() {
        
       });

     


    }

  
  }
    
});