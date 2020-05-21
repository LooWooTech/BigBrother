(function () {
    String.prototype.repeat = function (count) {
        if (this == null) {
            throw new TypeError('can\'t convert ' + this + ' to object');
        }
        var str = '' + this;
        count = +count;
        if (count != count) {
            count = 0;
        }
        if (count < 0) {
            throw new RangeError('repeat count must be non-negative');
        }
        if (count == Infinity) {
            throw new RangeError('repeat count must be less than infinity');
        }
        count = Math.floor(count);
        if (str.length == 0 || count == 0) {
            return '';
        }
        // Ensuring count is a 31-bit integer allows us to heavily optimize the
        // main part. But anyway, most current (August 2014) browsers can't handle
        // strings 1 << 28 chars or longer, so:
        if (str.length * count >= 1 << 28) {
            throw new RangeError('repeat count must not overflow maximum string size');
        }
        var rpt = '';
        for (; ;) {
            if ((count & 1) == 1) {
                rpt += str;
            }
            count >>>= 1;
            if (count == 0) {
                break;
            }
            str += str;
        }
        // Could we try:
        // return Array(count + 1).join(this);
        return rpt;
    };
    String.prototype.trimStart = function (trimStr) {
        if (!trimStr) { return this; }
        var temp = this;
        while (true) {
            if (temp.substr(0, trimStr.length) != trimStr) {
                break;
            }
            temp = temp.substr(trimStr.length);
        }
        return temp;
    };
    String.prototype.trimEnd = function (trimStr) {
        if (!trimStr) { return this; }
        var temp = this;
        while (true) {
            if (temp.substr(temp.length - trimStr.length, trimStr.length) != trimStr) {
                break;
            }
            temp = temp.substr(0, temp.length - trimStr.length);
        }
        return temp;
    };
    String.prototype.trim = function (trimStr) {
        var temp = trimStr;
        if (!trimStr) { temp = " "; }
        return this.trimStart(temp).trimEnd(temp);
    };

    $.fn.setUpload = function (uploadUrl, callback, beforeUpload) {
        var url = uploadUrl;
        if (typeof uploadUrl === "function") {
            url = uploadUrl();
        }
        var file = $(this);
        var text = file.prev().prev().html();
        var fileId = file.attr("id");
        if (!fileId) {
            fileId = Math.random();
            file.attr("id", "file-" + fileId);
        }
        var controlName = file.attr("name");
        if (!controlName) {
            file.attr("name", fileId);
            controlName = fileId;
        }
        if (url.indexOf("?") === -1) {
            url += "?";
        }
        url += "&controlName=" + controlName;
        var form = file.parents("form");
        var formAction = form.attr("action");
        var formTarget = form.attr("target");

        file.change(function () {

            var formData = new FormData();
            formData.append(controlName, file.get(0).files[0]);

            if (beforeUpload && !beforeUpload()) {
                reset();
                return;
            }

            file.prev().prev().text('上传中...');
            file.attr('disabled', 'disabled');

            // 加 setTimeout 以保证上传操作执行之前页面的正确渲染
            setTimeout(function () {
                $.ajax({
                    type: "POST",
                    async: false,
                    cache: false,
                    contentType: false, //不设置内容类型
                    processData: false, //不处理数据
                    url: url,
                    data: formData,
                    complete: function (xhr) {
                        callback(JSON.parse(xhr.responseText));
                        reset();
                    }
                });
            }, 500);
        });

        function reset() {
            file.prev().prev().html(text);
            file.removeAttr('disabled');

            var fileId = file.attr("id");
            var newFile = file.clone();
            newFile.value = "";
            file.replaceWith(newFile);
            form.removeAttr("target");
            form.removeAttr("enctype");
            form.attr("action", formAction);
            if (formTarget) {
                form.attr("target", formTarget);
            }
            $("#" + fileId).setUpload(uploadUrl, callback, beforeUpload);
        }
    };

    $.fn.serializeObject = function () {
        var form = this[0];
        if (!form) return null;
        var data = {};

        var arr = $(this).serializeArray();
        $.each(arr, function (i, item) {
            setFields(data, item.name, item.value);
        });

        return data;

        function setFields(data, name, value) {
            var dotIndex = name.indexOf('.')
            if (dotIndex > -1) {
                var key = name.substring(0, dotIndex);
                var subName = name.substring(dotIndex + 1);
                if (!data[key]) data[key] = {};
                setFields(data[key], subName, value);
                return;
            }

            if (data[name]) {
                data[name] += "," + value;
            }
            else {
                data[name] = value;
            }
        }
    };

    $.request = function (url, data, success, error, global) {
        var options = null;
        if (arguments.length === 1) {
            switch (typeof arguments[0]) {
                case "object":
                    options = arguments[0];
                    break;
                case "string":
                    options = { url: url };
            }
        } else {
            switch (typeof (arguments[1])) {
                case "function":
                    options = {
                        url: arguments[0],
                        data: null,
                        success: arguments[1],
                        error: arguments.length > 2 ? arguments[2] : null,
                        global: arguments.length > 3 ? arguments[3] : null,
                    };
                    break;
                default:
                    options = {
                        url: url,
                        data: data,
                        success: success,
                        error: error,
                        global: global
                    };
                    break;
            }
        }

        $.ajax({
            type: options.data ? "POST" : "GET",
            dataType: typeof options.data === "object" ? "json" : "text",
            global: options.global == undefined,
            url: options.url,
            data: options.data,
            complete: function (xhr) {
                switch (xhr.status) {
                    case 200:
                    case 204:
                        var json = {};
                        var responseText = xhr.responseText;
                        if (responseText) {
                            json = $.parseJSON(responseText);
                        }
                        if (options.success) {
                            options.success(json, xhr.statusText, xhr);
                        }
                        break;
                    default:
                        try {
                            var data = {};
                            if (xhr.responseText) {
                                data = $.parseJSON(xhr.responseText);
                                if (options.error) {
                                    options.error(data);
                                }
                            }
                        } catch (err) {
                            alert(err);
                        }
                        break;
                }
            }
        });
    };
    $.fn.loadUrl = function (href, cb) {
        var self = $(this);
        href = href || self.attr("href") || "";
        if (href && href[0] === "#") {
            href = href.substring(1);
        }
        if (!href) {
            return false;
        }
        self.attr("href", href);
        var hash = "#" + href;
        if (self.attr('id') === 'main' && window.location.hash.trimEnd('/').toString() !== hash.trimEnd('/').toString()) {
            window.location.hash = hash;
            return;
        }
        else {
            self.loadPage(href, cb);
        }
    };

    $.fn.reload = function (href) {
        var self = $(this);
        href = href || self.attr("href") || "";
        if (!href) {
            href = window.location.href;
        }
        self.loadPage(href);
    };


    $.fn.loadPage = function (href, cb) {
        if (!href) return;
        var self = $(this);
        self.attr("href", href);
        self.load(href, function (response, status, xhr) {
            if (status === "error") {
                self.html(getErrorContent(response, status, xhr));
            } else {
                if (cb) {
                    cb();
                }
            }
        });

        function getErrorContent(response, status, xhr) {
            var errorHtml = '<div class="col-md-12 mx-mt15">' +
                '<div class="panel panel-default">' +
                '<div class="page-header"><h2>{title}</h2></div>' +
                '<div class="mx-content-box">' +
                '<div class="mx-pa15">{content}</div>' +
                '</div>' +
                '</div>' +
                '</div>';
            var title = status + xhr.status;
            var content = "程序出错了";
            try {
                var err = JSON.parse(response);
                title = err.message;
                content = err.stackTrace.replace(/\n/g, '<br />');
            }
            catch (ex) {
                content = response || "未知错误";
            }
            if (xhr.status === 404) {
                content = "页面未找到";
            }
            return errorHtml.replace("{title}", title).replace("{content}", content);
        }
    };

    var modals = [];
    //打开一个新弹窗，targetId不存在自动创建
    $.openModal = function (targetId, href, style) {
        if ($(targetId).length > 0) {
            $.closeModal(targetId);
        }
        var modalHtml = '<div id="' + targetId.substring(1) + '" class="modal fade" aria-hidden="true" role="dialog" data-backdrop="static" data-keyboard="false">                           '
            + '           <div class="modal-dialog" role="document" style="' + style + '">                                                                            '
            + '               <div class="modal-content">                                                                                       '
            + '                   <div class="modal-header"><h4 class="modal-title">加载中，请稍候...</h4></div>'
            + '                   <div class="modal-body"><div style="height:300px;"></div></div>'
            + '               </div>                                                                                                            '
            + '           </div>                                                                                                                '
            + '       </div>   ';

        $('body').append(modalHtml);
        $(targetId).modal('show');
        $(targetId + ' .modal-content').load(href, function (response, status, xhr) {
            switch (xhr.status) {
                case 200:
                    modals.push(targetId);
                    break;
                default:
                    $.closeModal(targetId);
                    break;
            }
        });
    };
    //关闭一个弹窗（默认为最后一个）
    $.closeModal = function (targetId) {
        var backdropIndex = modals.length - 1;
        if (!targetId && modals.length > 0) {
            targetId = modals.pop();
        }

        for (var i = 0; i < modals.length; i++) {
            if (modals[i] === targetId) {
                modals.splice(i, 1);
                backdropIndex = i;
            }
        }
        $(targetId).modal('hide');
        $(targetId).remove();
        $('.modal').css('overflow', 'auto');
        $('.modal-backdrop').eq(backdropIndex).remove();
        $('body').removeClass('modal-open');
        $('body').css('padding-right', 0);
    };

})();


var onRequest = false;
$.ajaxSetup({
    beforeSend: function (xhr) {
        xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
        onRequest = true;
        setTimeout(function () {
            if (onRequest) {
                $("#loading").show();
            }
        }, 1000);
    }
});
$(document).ajaxComplete(function () {
    onRequest = false;
    $("#loading").hide();
});
$(document).ajaxError(function (event, jqxhr, settings, exception) {
    if (jqxhr.status === 404) {
        alert("页面未找到");
    }
    else if (jqxhr.responseText) {
        try {
            var result = $.parseJSON(jqxhr.responseText);
            alert(result.message || result.content || "未知错误");
        } catch (ex) {
            console.log(ex)
        }
    }
});
