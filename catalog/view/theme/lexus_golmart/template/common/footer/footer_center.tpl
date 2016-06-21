<div class="<?php echo str_replace('_','-',$blockid); ?> <?php echo $blockcls;?>" id="pavo-<?php echo str_replace('_','-',$blockid); ?>">
  <div class="container">
    <div class="inside space-padding-tb-40">
      <div class="row">
        <?php if ($informations) { ?>
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-3 column text-center">
          <div class="panel">
            <div class="panel-heading"><h3 class="panel-title text-center">Chính sách</h3></div>
            <div class="panel-body">
              <ul class="list-unstyled">
                <?php foreach ($informations as $information) { ?>
                <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                <?php } ?>
              </ul>
            </div>
          </div>
        </div>
        <?php } ?>
        
       <div class="col-xs-12 col-sm-12 col-md-6 col-lg-3 column text-center">
            <div class="panel">
                <div class="panel-heading"><h3 class="panel-title text-center">Danh mục</h3></div>
                <div class="panel-body">
                    <ul class="list-unstyled">
                        <li><a href="./san-pham-moi">Sản phẩm mới</a></li>
                        <li><a href="./san-pham-ban-chay">Sản phẩm bán chạy</a></li>
                        <li><a href="./san-pham-khuyen-mai">Sản phẩm khuyến mại</a></li>
                        <li><a href="./dong-ho-cap-doi">Đồng hồ cặp đôi</a></li>
                        <li><a href="./dan-ong-muon-so-huu-nhat">Đàn ông muốn sở hữu nhất</a></li>
                        <li><a href="./phu-nu-ua-thich-nhat">Phụ nữ ưa thích nhất</a></li>
                    </ul>
                </div>
            </div>
        </div>

        


        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-3 column text-center">
          <?php if( $content=$helper->getLangConfig('widget_logo') ) {?>
              <?php echo $content; ?>
          <?php } ?> 
        </div>
          <div class="col-xs-12 col-sm-12 col-md-6 col-lg-3 column text-center">
          <?php if( $content=$helper->getLangConfig('widget_about_us') ) {?>
          <?php echo $content; ?>            
          <?php } ?> 
        </div>
      </div>
    </div>
  </div>
</div>

