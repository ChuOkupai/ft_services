<?php

define('DB_NAME', 'wordpress');
define('DB_USER', 'wordpress');
define('DB_PASSWORD', 'wordpress');
define('DB_HOST', 'mysql');
define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');

define('AUTH_KEY',         'lD#}rO.pd+,_V1-{a(jI+LCQ5Q8RS;R$@mF#~C>voGS@l|xw^O+:)dTf<I{NOaWt');
define('SECURE_AUTH_KEY',  'hQZkNtcI*z81jnUo:=~,!U7}dqzn`Xg(>xlpiT<3m@&]0BYs4di*%g^To_|DI6 m');
define('LOGGED_IN_KEY',    'mOJ4c^D94{#f^3r*0UP;|a*`q2<eFDFIZ?@!r:~p?YCT=A(rCs05jdkn2,MfDi[f');
define('NONCE_KEY',        'scB.9&/;0s=&q#*PA9-X p<3gpoa3J1 1w-Nj-Pe6sshmQ^b;/lX#WL`O]q,8dFt');
define('AUTH_SALT',        '<1roSB. 6IX89R/P<7qY`cT;~ a}NT*oLFr+nH{Wp(ItAk-3Y d8ZE9lo[q}Nv.h');
define('SECURE_AUTH_SALT', '1Y8;*c}d0_Y)y|5mPwLaWf]]%?<ga9Qe-~|j)Me_`RbknZ6|o|?pREMo+]-@?HBV');
define('LOGGED_IN_SALT',   'm`4BEY IB=m{xzhj ~y&K_q<YyA?tMk_/*F!zBOH/-q+v7,|aV[L qt[PK-aC1G/');
define('NONCE_SALT',       '^NGb+~BXno-Kdq4?Z|,2,J0Z.+JpStp:#Iv((NWLnI=q2|+A /]N^>t.45nSw,D-');

$table_prefix = 'wp_';
define('WP_DEBUG', false);

if (!defined('ABSPATH'))
{
	define('ABSPATH', __DIR__.'/');
}
require_once ABSPATH.'wp-settings.php';
