<html ng-app="Soil">
<head>
  <script src="/static/libs/angular-1.2.26/angular.min.js"></script>
  <script src="/static/libs/angular-cookies-1.2.26/angular-cookies.min.js"></script>
  <script src="/static/libs/jquery-1.11.1/jquery.min.js"></script>
  <script src="/static/libs/bootstrap-3.2.0/bootstrap.min.js"></script>
  <script src="/static/libs/bullet-1.0.0/bullet.js"></script>
  <script src="/static/libs/bert-js-1.0.0/bert.js"></script>

  <link href="/static/css/bootstrap-3.2.0/bootstrap.min.css" rel="stylesheet">
  <link href="/static/css/soil-0.0.1/soil.css" rel="stylesheet">

  <script src="/app/controllers/Main.js"></script>
  <script src="/app/services/News.js"></script>
  <script src="/app/services/Bullet.js"></script>
  <script src="/app/soil.js"></script>
</head>
<body ng-controller="MainController">

    <div class="site-wrapper">
      <div class="site-wrapper-inner">
        <div class="cover-container">
          <div class="masthead clearfix">
            <div class="inner">
              <h3 class="masthead-brand">Soil</h3>
              <nav>
                <ul class="nav masthead-nav">
                  <li ng-class="{ active: toggler.about }">
                     <a href="#" ng-click="visible('about')">About</a>
                 </li>
                  <li ng-class="{ active: toggler.connections }">
                     <a href="#" ng-click="visible('connections')">Connections</a>
                  </li>
                </ul>
              </nav>
            </div>
          </div>


          <!-- About -->          
          <div id="About" class="inner cover" ng-if="toggler.about">
            <h1 class="cover-heading">Welcome</h1>
            <p class="lead">Cover is a one-page template for building simple and beautiful home pages. Download, edit the text, and add your own fullscreen background photo to make it your own.</p>
          </div>

          <!-- Connections -->          
          <div id="Connections" class="inner cover" ng-if="toggler.connections">
            <h1 class="cover-heading">Server connections</h1>
            <p class="lead">
              <a href="#" ng-click="view()" class="btn btn-lg btn-default">View</a>
            </p> 
            <table class="table">
              <thead>
                <tr>
                  <th>Sid</th>
                  <th>Active</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                <tr ng-repeat="channel in channels">
                  <td>{[ channel.sid ]}</td>
                  <td>{[ channel.properties.active ]}</td>
                  <td><a class="btn btn-large btn-success" ng-click="send()">Send</a></td>
                </tr>
              </tbody>
            </table>  
          </div>

          <div class="mastfoot">
            <div class="inner">
              <p>Developed for <a href="http://www.gla.ac.uk/">Glasgow University</a>, by <a href="https://github.com/coolfeature">coolfeature</a>.</p>
            </div>
          </div>

        </div>

      </div>

    </div>

</body>
</html>

