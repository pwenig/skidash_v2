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

    },

    get_traffic_alerts: function(road) {
      var deferred = $q.defer();
      $http({
        url: urlBase + '/' + 'alert',
        method: 'GET',
        params: road
      }).then(function(response) {
        
        deferred.resolve(response['data'])

      })
      .catch(function(response) {
        deferred.reject(response)
      });
      return deferred.promise;

     
    },

    get_traffic_images: function(road) {
      var deferred = $q.defer();
      $http({
        url: urlBase + '/' + 'images',
        method: 'GET',
        params: road
      }).then(function(response) {
        
        deferred.resolve(response['data'])

      })
      .catch(function(response) {
        deferred.reject(response)
      });
      return deferred.promise;

     
    },

    get_traffic_speeds: function(road) {
      var deferred = $q.defer();
      $http({
        url: urlBase + '/' + 'speeds',
        method: 'GET',
        params: road
      }).then(function(response) {
        
        deferred.resolve(response['data'])

      })
      .catch(function(response) {
        deferred.reject(response)
      });
      return deferred.promise;

     
    }


  }

}]);