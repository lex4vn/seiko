<?php 
/******************************************************
 * @package Pav blog module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

/**
 * class ControllerpavblogBlog 
 */
class ControllerPavblogBlogs extends Controller {
	
		private $mparams = '';

		private $mdata = array();
		
		public function preload(){
		
			$this->mdata['objlang'] = $this->language;
			$this->mdata['objurl'] = $this->url;

			$this->load->model('tool/image'); 			
			$this->load->language('module/pavblog');
			$this->load->model("pavblog/blog");
			$this->load->model("pavblog/comment");

			$mparams = $this->config->get( 'pavblog' );
			$default = $this->model_pavblog_blog->getDefaultConfig();
			
			$mparams = !empty($mparams)?$mparams:array();

			if( $mparams ){
				$mparams =  array_merge( $default,$mparams);
			}else{
				$mparams = $default;
			}
			$config = new Config();
			if( $mparams ){
				foreach( $mparams as $key => $value ){
					$config->set( $key, $value );
				}
			}
			$this->mparams = $config; 
			
	
			if( !defined("_PAVBLOG_MEDIA_") ){
				if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavblog.css')) {
					$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavblog.css');
				} else {
					$this->document->addStyle('catalog/view/theme/default/stylesheet/pavblog.css');
				}
				define("_PAVBLOG_MEDIA_",true);
			}
		}
		
		public function getParam( $key, $value='' ){
			return  $this->mparams->get( $key, $value );
		}
		
		/**
		 * get model object
		 */
		public function getModel( $model='blog' ){
			return $this->{"model_pavblog_{$model}"};
		}
		
		/**
		 * get rss feed by category id 
		 */
		public function rss(){
			
			$this->preload();
			if( isset($this->request->get['id']) ){
				$id = (int)$this->request->get['id'];
			} else {
				$id = 0;
			}
			
			$category_info = $this->getModel()->getInfo( $id );	
			
			$output = '<?xml version="1.0" encoding="UTF-8" ?>';
			$output .= '<rss version="2.0">';
			$output .= '<channel>';

			$output .= '<title><![CDATA[' . $this->language->get('blogs_latest_header_title'). ' - ' . $this->config->get('config_name') . ']]></title>';
			$output .= '<description><![CDATA[' . $this->config->get('config_meta_description') . ']]></description>';
			$output .= '<link><![CDATA[' . HTTP_SERVER . ']]></link>';
			
			$page = 1;
			$limit = (int)$this->mparams->get('rss_limit_item')?(int)$this->mparams->get('rss_limit_item'):100;
			
			$this->mdata = array(
				'filter_category_id' => '',
				'sort'               => 'b.created',
				'order'              => 'ASC',
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);

			$blogs = $this->getModel('blog')->getListBlogs(  $this->mdata );
			

			foreach( $blogs as $blog ){
				$link =  str_replace("&amp;","&",$this->url->link( 'pavblog/blog','id='.$blog['blog_id'] ));
				if( $blog['image'] ){
					$image = $this->model_tool_image->resize($blog['image'], $this->mparams->get('general_swidth'), $this->mparams->get('general_sheight') ,'w' );
					$description = '<a href="'.$link.'"><img class="rss_blog_image" src="'.$image.'"/></a>'.  html_entity_decode($blog['description'], ENT_QUOTES, 'UTF-8'); 
				}else {
					$description =  html_entity_decode($blog['description'], ENT_QUOTES, 'UTF-8');
				} 
			
				$output .= '<item>';
				$output .= '<title><![CDATA[' . $blog['title'] . ']]></title>';
				$output .= '<link><![CDATA[' .$link. ']]></link>';
				$output .= '<description><![CDATA[' . $description . ']]></description>';
				$output .= '<guid>' . $blog['blog_id'] . '</guid>';
				$output .= '<pubDate>' . date('D, j F Y H:i:s e', strtotime($blog['created'])) . '</pubDate>';
				$output .= '</item>';
			}
			$output .= '</channel>';
			$output .= '</rss>';
			$this->response->addHeader('Content-Type: application/rss+xml');
			$this->response->setOutput($output);
		
		}
		/**
		 * index action
	     *
		 */
		public function index() {  
			 
			$this->preload();
			
			if (isset($this->request->get['filter'])) {
				$filter = $this->request->get['filter'];
			} else {
				$filter = '';
			}
					
			if (isset($this->request->get['sort'])) {
				$sort = $this->request->get['sort'];
			} else {
				$sort = 'b.sort_order';
			}

			if (isset($this->request->get['order'])) {
				$order = $this->request->get['order'];
			} else {
				$order = 'DESC';
			}
			
			if (isset($this->request->get['page'])) {
				$page = $this->request->get['page'];
			} else { 
				$page = 1;
			}	
								
			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit =  (int)$this->mparams->get( 'cat_limit_leading_blog' ) +  (int)$this->mparams->get( 'cat_limit_secondary_blog' );
			}
		

			$this->load->model("pavblog/category");
			$users = $this->getModel('category')->getUsers();
			$this->mdata['config']	 = $this->mparams; 
			
			if( isset($this->request->get['tag']) ){
				$filter_tag = $this->request->get['tag'];
			}else {
				$filter_tag = '';
			}
			
			$this->mdata = array(
				'filter_category_id' => '',
				'filter_filter'      => $filter, 
				'filter_tag'  		 => $filter_tag,
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);
			
			if( $filter || $filter_tag ){
				$this->mdata['heading_title'] = $this->language->get('filter_blog_header_title');
			} else {
				$this->mdata['heading_title'] = $this->language->get('blogs_latest_header_title');
				$this->mdata['sort'] = 'b.created';
				$order = 'DESC';
			}
			
		
			$blogs = $this->getModel( 'blog' )->getListBlogs(  $this->mdata );
			
			if ($blogs) {
				
				
				$total = $this->getModel( 'blog' )->getTotal( $this->mdata );
				
				$url = '';
				
				if (isset($this->request->get['sort'])) {
					$url .= '&sort=' . $this->request->get['sort'];
				}	

				if (isset($this->request->get['order'])) {
					$url .= '&order=' . $this->request->get['order'];
				}	
				
				if (isset($this->request->get['limit'])) {
					$url .= '&limit=' . $this->request->get['limit'];
				}
				
				if (isset($this->request->get['tag'])) {
					$url .= '&tag=' . $this->request->get['tag'];
					$this->mdata['heading_title'] = sprintf($this->mdata['heading_title'] , "tag: ".$this->request->get['tag']);
				}
                if(null !== $this->mparams->get('description')){
				    $this->document->setDescription( $this->mparams->get('description') );
                }
				
                if(null !== $this->mparams->get('title')){
				    $this->document->setTitle( $this->mparams->get('title') );
                }
				
                if(null !== $this->mparams->get('keywords')){
				    $this->document->setKeywords( $this->mparams->get('keywords') );
                }
                
				$limit_leading_blogs = (int)$this->mparams->get( 'cat_limit_leading_blog' );
				$type = array('l'=>'thumb_large','s'=>'thumb_small');
				$limageType = isset($type[$this->mparams->get('cat_leading_image_type')])?$type[$this->mparams->get('cat_leading_image_type')]:'thumb_xsmall';
				$simageType = isset($type[$this->mparams->get('cat_secondary_image_type')])?$type[$this->mparams->get('cat_secondary_image_type')]:'thumb_xsmall';
				
	
				foreach( $blogs as $key => $blog ){
					if( $blogs[$key]['image'] ){	
						$blogs[$key]['thumb_large'] = $this->model_tool_image->resize($blog['image'], $this->mparams->get('general_lwidth'), $this->mparams->get('general_lheight'),'w');
						$blogs[$key]['thumb_small'] = $this->model_tool_image->resize($blog['image'], $this->mparams->get('general_swidth'), $this->mparams->get('general_sheight') ,'w');
						$blogs[$key]['thumb_xsmall'] = $this->model_tool_image->resize($blog['image'],$this->mparams->get('general_xwidth'), $this->mparams->get('general_xheight'),'w' );
					}else {
						$blogs[$key]['thumb_large'] = '';
						$blogs[$key]['thumb_small'] = '';
						$blogs[$key]['thumb_xsmall'] = '';
					}
					if( $key < $limit_leading_blogs ){
						$blogs[$key]['thumb'] = $blogs[$key][$limageType];
					}else {
						$blogs[$key]['thumb'] = $blogs[$key][$simageType];
					}					
					
					$blogs[$key]['description'] = html_entity_decode($blog['description'], ENT_QUOTES, 'UTF-8');
					$blogs[$key]['author'] = isset($users[$blog['user_id']])?$users[$blog['user_id']]:$this->language->get('text_none_author');
					$blogs[$key]['category_link'] =  $this->url->link( 'pavblog/category', "blogcategory_id=".$blog['category_id'] );
					$blogs[$key]['comment_count'] =  $this->getModel('comment')->countComment( $blog['blog_id'] );
					$blogs[$key]['link'] =  $this->url->link( 'pavblog/blog','blog_id='.$blog['blog_id'] );
				}
				
				$leading_blogs 		 = array_slice( $blogs,0, $limit_leading_blogs );
				$secondary_blogs 	 = array_splice( $blogs, $limit_leading_blogs, count($blogs) );
		
				
			 	$this->mdata['config'] = $this->mparams;
				$this->mdata['leading_blogs'] = $leading_blogs;
				$this->mdata['secondary_blogs'] = $secondary_blogs;
				$this->mdata['latest_rss'] =  $this->url->link( 'pavblog/blogs/rss' );
				
				$pagination = new Pagination();
				$pagination->total = $total;
				$pagination->page = $page;
				$pagination->limit =  $limit;
				$pagination->text = $this->language->get('text_pagination');
				$pagination->url = $this->url->link('pavblog/blogs',  $url . '&page={page}');

				$this->mdata['results'] = sprintf($this->language->get('text_pagination'), ($total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($total - $limit)) ? $total : ((($page - 1) * $limit) + $limit), $total, ceil($total / $limit));

				$this->mdata['pagination'] = $pagination->render();

				$this->mdata['column_left'] = $this->load->controller('common/column_left');
				$this->mdata['column_right'] = $this->load->controller('common/column_right');
				$this->mdata['content_top'] = $this->load->controller('common/content_top');
				$this->mdata['content_bottom'] = $this->load->controller('common/content_bottom');
				$this->mdata['footer'] = $this->load->controller('common/footer');
				$this->mdata['header'] = $this->load->controller('common/header');

				$this->mdata['objlang'] = $this->language;
				$this->mdata['objurl'] = $this->url;

				$this->mdata['breadcrumbs'][] = array(
					'text'      => $this->language->get('text_home'),
					'href'      => $this->url->link('common/home'),
				);
				$this->mdata['breadcrumbs'][] = array(
					'text'      => $this->language->get('text_blogs'),
					'href'      => $this->url->link('pavblog/blogs'),
				);

				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/pavblog/blogs.tpl')) {
					$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/pavblog/blogs.tpl', $this->mdata));
				} else {
					$this->response->setOutput($this->load->view('default/template/pavblog/blogs.tpl', $this->mdata));
				}
				

			} else {
				$category_id = isset($this->request->get["id"])?$this->request->get["id"]:0;
				$this->mdata['breadcrumbs'][] = array(
					'text'      => $this->language->get('text_error'),
					'href'      => $this->url->link('information/information', 'category_id=' . $category_id),
					'separator' => $this->language->get('text_separator')
				);
					
				$this->document->setTitle($this->language->get('text_error'));
				
				$this->mdata['heading_title'] = $this->language->get('text_error');

				$this->mdata['text_error'] = $this->language->get('text_error');

				$this->mdata['button_continue'] = $this->language->get('button_continue');
				
				$this->mdata['continue'] = $this->url->link('common/home');

				$this->mdata['column_left'] = $this->load->controller('common/column_left');
				$this->mdata['column_right'] = $this->load->controller('common/column_right');
				$this->mdata['content_top'] = $this->load->controller('common/content_top');
				$this->mdata['content_bottom'] = $this->load->controller('common/content_bottom');
				$this->mdata['footer'] = $this->load->controller('common/footer');
				$this->mdata['header'] = $this->load->controller('common/header');

				$this->mdata['objlang'] = $this->language;
				$this->mdata['objurl'] = $this->url;

				$this->mdata['breadcrumbs'][] = array(
					'text'      => $this->language->get('text_home'),
					'href'      => $this->url->link('common/home'),
				);
				$this->mdata['breadcrumbs'][] = array(
					'text'      => $this->language->get('text_blogs'),
					'href'      => $this->url->link('pavblog/blogs'),
				);

				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
					$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $this->mdata));
				} else {
					$this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $this->mdata));
				}
			}
		}
		
	}	
	?>