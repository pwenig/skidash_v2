angular.module('skidash')
.controller('MountainCtrl', MountainCtrl);

MountainCtrl.$inject = ['$scope'];

function MountainCtrl ($scope) {

  $scope.show_volume = true;

}