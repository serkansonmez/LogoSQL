declare @body1 varchar(4000)
declare @body2 varchar(4000)

set @body2 = '
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.container {
  position: relative;
  text-align: center;
  color: white;
}

.bottom-left {
  position: absolute;
  bottom: 8px;
  left: 16px;
}

.top-left {
  position: absolute;
  top: 8px;
  left: 16px;
}

.top-right {
  position: absolute;
  top: 8px;
  right: 16px;
}

.bottom-right {
  position: absolute;
  bottom: 8px;
  right: 16px;
}

.centered {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
</style>
</head>
<body>

<h2>Image Text</h2>
<p>How to place text over an image:</p>

<div class="container">
  <img src="img_snow_wide.jpg" alt="Snow" style="width:100%;">
  <div class="bottom-left">Bottom Left</div>
  <div class="top-left">Top Left</div>
  <div class="top-right">Top Right</div>
  <div class="bottom-right">Bottom Right</div>
  <div class="centered">Centered</div>
</div>

</body>'


set @body1 = '<head>

<title> Embedded Logo Example</title>

<meta name="Generator" content="EditPlus">

<meta name="Author" content="">

<meta name="Keywords" content="">

<meta name="Description" content="">

</head>

<body>

<table><tr><td valign="top" align="left">MyHeader</td></tr>

<tr><td valign="top" align="left"><img src="cid:Continental_logo.png" width="235" height="70" border="0" alt=""></td></tr>

</table>

</body>'

EXEC msdb.dbo.sp_send_dbmail

    @profile_name='sql mail service',

    @recipients='serkansonmez16@hotmail.com',

    @subject = 'Doðum Günü Tebriði',

    @body = @body2,

    @body_format = 'HTML',

    @query = 'SELECT top 3 * from sysobjects where xtype=''U''',

    @query_result_header = 0,

    @exclude_query_output = 1,

    @append_query_error = 1,

    @attach_query_result_as_file = 1,

    @query_attachment_filename = 'results.txt',

    @query_result_no_padding = 1,

    @file_attachments = 'd:\Continental_logo.png'