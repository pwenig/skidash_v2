app.factory("Mountain", function($http, $q) {

    var urlBase = '/mountains';
    var deferred = $q.defer();

    return {
      get: function() {
          $http.get(urlBase).then(function(response){
             deferred.resolve(response.data);
          })
          .catch(function(response){
            deferred.reject(response);
          });
          return deferred.promise;
      },

      get_forecast: function( mountain) {

        console.log('GETWEATHER', mountain)
      }

      
    }
  
  });