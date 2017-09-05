angular.module('skidash')
.service('Road', [ '$http', '$q', function($http, $q) {

  var urlBase = '/roads';

  return {

    get: function() {
      var deferred = $q.defer();
      $http.get(urlBase).then(function(response){
        deferred.resolve(response.data);
      })
      .catch(function(response){
        deferred.reject(response)
      });
      return deferred.promise;
    }

  }

}]);