<html ng-app="Soil">
<head>
  <script src="/static/libs/angular-1.2.26/angular.min.js"></script>
  <script src="/static/libs/jquery-1.11.1/jquery.min.js"></script>
  <script src="/static/libs/bootstrap-3.2.0/bootstrap.min.js"></script>
  <script src="/static/libs/bullet-1.0.0/bullet.js"></script>

  <link href="/static/css/bootstrap-3.2.0/bootstrap.min.css" rel="stylesheet">
  <link href="/static/css/soil-0.0.1/soil.css" rel="stylesheet">

  <script src="/app/controllers/Main.js"></script>
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
                  <li class="active"><a href="#">Soil</a></li>
                  <li><a href="#">Features</a></li>
                  <li><a href="#">Contact</a></li>
                </ul>
              </nav>
            </div>
          </div>

          <div class="inner cover">
            <h1 class="cover-heading">Cover your page.</h1>
            <p class="lead">Cover is a one-page template for building simple and beautiful home pages. Download, edit the text, and add your own fullscreen background photo to make it your own.</p>
            <p class="lead">
              <a href="#" class="btn btn-lg btn-default">Learn more</a>
            </p>
          </div>

          <div class="mastfoot">
            <div class="inner">
              <p>Developed for <a href="http://www.gla.ac.uk/">Glasgow University</a>, by <a href="https://github.com/coolfeature">coolfeature</a>.</p>
            </div>
          </div>

        </div>

      </div>

    </div>

  <!-- -->
  <div style="color:sienna">{{ sid }}</div>
  <div ng-model="sid" id="session_id" style="display:none">{{ sid }}</div>
  <div id="hostname" style="display:none">{{ hostname }}</div>
  <div id="client_timeout" style="display:none">{{ client_timeout }}</div>
</body>
</html>

