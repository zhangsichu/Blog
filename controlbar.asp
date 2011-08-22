<table width="100%">
    <tr>
        <td align="left">
            <div style="margin-left: 13px">
                <a href="javascript:ChangeAllCss('images/lightblue.css');">
                    <img src="images/blue_icon.gif" alt="blueSkin" border="0px" /></a> <a href="javascript:ChangeAllCss('images/pink.css');">
                        <img src="images/pink_icon.gif" alt="pinkSkin" border="0px" /></a> <a href="javascript:ChangeAllCss('images/white.css');">
                            <img src="images/white_icon.gif" alt="whiteSkin" border="0px" /></a>
                <a href="javascript:ChangeAllCss('images/black.css');">
                    <img src="images/black_icon.gif" alt="blackSkin" border="0px" /></a> <a href="javascript:ChangeAllCss('images/surf.css');">
                        <img src="images/surf_icon.gif" alt="" border="0px" /></a> <a href="javascript:ChangeAllCss('images/peachblow.css');">
                            <img src="images/peachblow_icon.gif" alt="" border="0px" /></a></div>
        </td>
        <td align="right">
            <div id="displayUser" visible="false">
            </div>
            <img id="backContrl" src="images/back_inactive.gif" alt="Back" onclick="BlogHistory.doBack(); SetHistoryControlStatus(); return false;"
                onmouseover="BackMouseOverStyle();" onmouseout="BackMouseNormalStyle();" disabled />
            <img id="forwardControl" src="images/forward_inactive.gif" alt="Forward" onclick="BlogHistory.doForward(); SetHistoryControlStatus(); return false;"
                onmouseover="ForwardMouseOverStyle();" onmouseout="ForwardMouseNormalStyle();"
                disabled />
            <img id="refreshControl" src="images/refresh_inactive.gif" alt="Refresh" onclick="BlogHistory.doRefresh(); SetHistoryControlStatus(); return false;"
                onmouseover="RefreshMouseOverStyle();" onmouseout="RefreshMouseNormalStyle();"
                disabled />
            <img id="homeControl" src="images/home_active.gif" alt="Home" onclick="GetClassDisplay('defaultresponse.asp'); return false;"
                onmouseover="HomeMouseOverStyle();" onmouseout="HomeMouseNormalStyle();" />
            <%Response.Write(FormatDatetime(Date(),1)&" "&WeekdayName(Weekday(Date())))%>
            <a href="blogrss.asp" target="_blank">
                <img src="images/rss3.gif" alt="RSS" style="border: 0px" /></a> <a href="#" onclick="javascript:OpenCLIWindow(); return false;">
                    <img src="images/cli.gif" alt="CLI" style="border: 0px" /></a>
					<a href="Html5/MineSweeper/CanvasMineSweeperRelease.htm" target="_blank"><img src="images/sweeper.gif" alt="Mine Sweeper. In Javascript." style="border: 0px" /></a>
        </td>
    </tr>
</table>