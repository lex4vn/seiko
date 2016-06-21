<?php
  $this->language( 'module/themecontrol' );
  $objlang = $this->registry->get('language');
  $megamenu = $helper->renderModule('pavmegamenu');
  $autosearch = $helper->renderModule('pavautosearch');
  $verticalmenu = $helper->renderModule('pavverticalmenu');
  if( isset($_COOKIE[$themeName .'_skin']) && $_COOKIE[$themeName .'_skin'] ){
    $skin = trim($_COOKIE[$themeName .'_skin']);
  }
?>

<header id="header-layout"  class="header-v4">

<nav id="topbar">
  <div class="container">
    <div class="topbar-wrap clearfix">
          <?php if( $content=$helper->getLangConfig('widget_support') ) {?>
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 text-left hidden-xs ">
              <?php echo $content; ?>
            </div>
          <?php } ?> 
        <div class="login col-xs-12 col-sm-6 col-md-6 col-lg-6">
        <ul class="links text-right">
          <?php if ($logged) { ?>
            <li>  <a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a><span>|</span></li>
            <?php } else { ?>
            <li>  <a href="<?php echo $register; ?>"><?php echo $text_register; ?></a><span>|</span></li>
            <li>  <a href="<?php echo $login; ?>"><?php echo $text_login; ?></a><span>|</span></li>
            <?php } ?>
          <li><a class="" href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
        </ul>
      </div>
    </div>
   </div>
</nav>
<div class="header-top">
  <div class="container">
    <div class="inside">
      <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-5 xs-text-center sm-text-center">
          <!-- logo -->
          <?php if( $logoType=='logo-theme'){ ?>
          <div  id="logo-theme" class="logo-store"><a href="" class="img-responsive"><span><?php echo $name; ?></span></a></div>
          <?php } elseif ($logo) { ?>
          <div id="logo" class="logo-store">
              <?php if (isset($ishome)) {?>
                <h1 class="hidden"><?php echo $name; ?></h1>
              <?php }else{ ?>
                <h2 class="hidden"><?php echo $name; ?></h2>
              <?php } ?>
              <a href="" class="img-responsive"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
          <?php } ?>
        </div>
        
        <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 hidden-xs">
           <?php
            if (count($autosearch) && !empty($autosearch)) {
            echo $autosearch;
            } else {
            echo $search;
            }
            ?>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 xs-text-center sm-text-center">
          <?php if( $contact=$helper->getLangConfig('widget_contact') ) {?>
            <div class="box-contact">
              <?php echo $contact; ?>
            </div>
          <?php } ?> 
        </div>       
        <div class="col-xs-12 col-sm-12 col-md-1 col-lg-1 hidden-xs hidden-sm">
          <?php echo $cart; ?>       
        </div>
      </div>
    </div>
  </div>
</div

<div class="header-bottom">
    <div class="container">
      <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="main-menu">
              <!-- menu -->
              <div id="pav-mainnav" class="pav-mainnav"><div class="pav-megamenu">
              <button data-toggle="offcanvas" class="btn btn-primary hidden-lg hidden-md" type="button"><span class="fa fa-bars"></span> Menu</button>
              <?php
              /**
              * Main Menu modules: as default if do not put megamenu, the theme will use categories menu for main menu
              */
              if (count($megamenu) && !empty($megamenu)) { echo $megamenu;?>
              <?php } elseif ($categories) { ?>
              <nav id="menu" class="navbar">
              <div class="collapse navbar-collapse navbar-ex1-collapse">
              <ul class="nav navbar-nav">
                <?php foreach ($categories as $category) { ?>
                <?php if ($category['children']) { ?>
                <li class="dropdown"><a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
                <div class="dropdown-menu">
                  <div class="dropdown-inner">
                    <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
                    <ul class="list-unstyled">
                      <?php foreach ($children as $child) { ?>
                      <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                      <?php } ?>
                    </ul>
                    <?php } ?>
                  </div>
                  <a href="<?php echo $category['href']; ?>" class="see-all"><?php echo $text_all; ?> <?php echo $category['name']; ?></a> </div>
                </li>
                <?php } else { ?>
                <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                <?php } ?>
                <?php } ?>
              </ul>
              </div>
              </nav>
              <?php } ?>
              </div>
              </div> 
            <!-- menu -->  
            </div>
        </div>  
      </div>
    </div>
  </div>
</header>

