angular.module('skidash')
.service('Mountain', Mountain)

Mountain.$inject = ['$http', '$q'];

function Mountain ($http, $q) {

    var urlBase = '/mountains';

    return {
      
      get: function() {
          var deferred = $q.defer();
          $http.get(urlBase).then(function(response){
             deferred.resolve(response.data);
          })
          .catch(function(response){
            deferred.reject(response);
          });
          return deferred.promise;
      },

      get_forecast: function( mountain ) {
        var deferred = $q.defer();
        $http({
          url: urlBase + '/'+ 'forecast', 
          method: "GET",
          params: {mountain: mountain.zip_code}
        }).then(function(response) {
          deferred.resolve(response['data'])
        })
        .catch(function(response) {

          deferred.reject(response)

        });
        return deferred.promise;
      }
      
    }
  
  };