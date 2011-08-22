Ext.require([
    'Ext.form.*',
    'Ext.data.*',
    'Ext.window.MessageBox'
]);

Ext.onReady(function () {
    function CreateInfoPanel(userName) {
        var panel = new Ext.Window({
            title: ' 我 要 报 名',
            width: 570,
            bodyPadding: 5,
            closable: true,
            modal: true,
            resizable: false,
            items: [
        new Ext.FormPanel({
            width: 550,
            bodyPadding: 10,
            fieldDefaults: {
                labelAlign: 'left',
                labelWidth: 45,
                margin: '0 0 0 10',
                msgTarget: 'qtip'
            },
            items: [
            {
                xtype: 'fieldset',
                title: '我的信息',
                defaultType: 'textfield',
                layout: 'anchor',
                defaults: {
                    anchor: '100%'
                },
                items: [{
                    xtype: 'fieldcontainer',
                    fieldLabel: '大名',
                    layout: 'hbox',
                    defaultType: 'textfield',
                    defaults: {
                        hideLabel: 'true'
                    },
                    items: [{
                        name: 'Name',
                        fieldLabel: '',
                        flex: 1,
                        emptyText: '您的名字',
                        blankText: '请输入您的名字!',
                        value: userName,
                        allowBlank: false
                    }]
                }, {
                    xtype: 'fieldcontainer',
                    fieldLabel: '电话',
                    emailText: '请输入您的电话！',
                    layout: 'hbox',
                    defaultType: 'textfield',
                    defaults: {
                        hideLabel: 'true'
                    },
                    items: [{
                        name: 'Phone',
                        flex: 1,
                        blankText: '请输入您的联系电话!',
                        allowBlank: false,
                        emptyText: '手机号码',
                        maskRe: /[\d\-]/,
                        regex: /^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\d{8}$/,
                        regexText: '请输入正确的手机号码！'
                    }]
                }, {
                    xtype: 'fieldcontainer',
                    fieldLabel: '电邮',
                    emailText: '请输入您的电邮地址！',
                    layout: 'hbox',
                    defaultType: 'textfield',
                    defaults: {
                        hideLabel: 'true'
                    },
                    items: [{
                        name: 'Email',
                        vtype: 'email',
                        emptyText: '电邮地址',
                        flex: 1,
                        blankText: '请输入您的电邮地址!',
                        allowBlank: false
                    }]
                }]
            }, {
                xtype: 'fieldset',
                title: '纪念品',
                layout: 'anchor',
                defaults: {
                    anchor: '100%'
                },
                fieldDefaults: {
                    labelAlign: 'left',
                    labelWidth: 45,
                    msgTarget: 'qtip'
                },
                items: [{
                    xtype: 'checkbox',
                    name: 'AllowPost',
                    boxLabel: ' 邮寄接收纪念品?',
                    hideLabel: true,
                    checked: false,
                    margin: '0 10 10 10',
                    handler: function (me, checked) {
                        var fieldset = me.ownerCt;
                        Ext.Array.forEach(fieldset.query('textfield'), function (field) {
                            field.setDisabled(!checked);
                            if (!Ext.isIE6) {
                                field.el.animate({ opacity: !checked ? .3 : 1 });
                            }
                        });
                    }
                }, {
                    xtype: 'textfield',
                    fieldLabel: '邮寄地址',
                    labelWidth: 75,
                    name: 'PostalAddress',
                    blankText: '请输入您的邮寄地址!',
                    margin: '0 0 10 10',
                    allowBlank: false,
                    style: (!Ext.isIE6) ? 'opacity:.3' : '',
                    disabled: true
                }, {
                    xtype: 'textfield',
                    fieldLabel: '邮政编码',
                    labelWidth: 75,
                    name: 'PostalCode',
                    style: (!Ext.isIE6) ? 'opacity:.3' : '',
                    disabled: true,
                    allowBlank: false,
                    maxLength: 6,
                    blankText: '请输入您的邮政编码!',
                    enforceMaxLength: true,
                    maskRe: /[\d\-]/,
                    regex: /^[1-9]\d{5}$/,
                    regexText: '请输入正确的邮政编码！'
                }]
            }, {
                xtype: 'fieldset',
                title: '还想留言',
                layout: 'anchor',
                defaults: {
                    anchor: '100%'
                },
                items: [{
                    xtype: 'textareafield',
                    name: 'SomeWord',
                    allowBlank: true,
                    height: '200'
                }]
            }],
            buttons: [{
                text: ' 报 名 ',
                width: 100,
                height: 30,
                id: 'Post',
                handler: function () {
                    var form = this.up('form').getForm();
                    if (form.isValid()) {
                        var buttonCmp = Ext.getCmp('Post');
                        var buttonEl = buttonCmp.getEl();
                        var waitingPanel = Ext.core.DomHelper.createDom({ tag: 'div', id: 'loadingPanel', class: 'loadingPanel', children: [{ tag: 'img', src: 'Styles/loading.gif', class: 'loadingImage'}] });
                        buttonEl.dom.parentNode.insertBefore(waitingPanel, buttonEl.dom);
                        buttonCmp.disable(true);

                        //TO DO.
                        //Call Ajax.
                        Ext.MessageBox.alert('Go!', form.getValues(true));
                    }
                }
            }]
        })]
        });
        return panel;
    }
    function ShowPost() {
        var index = this.getAttribute("index");
        var panel = CreateInfoPanel(window.classMates[index].name);
        panel.show();
    }
    var joinBody = Ext.select("#joinBody");
    for (var i = 0; i < window.classMates.length; i++) {
        var link = Ext.core.DomHelper.createDom({ tag: 'a', html: window.classMates[i].name, class: 'joinItem', index: i });
        Ext.get(link).on('click', ShowPost);
        joinBody.appendChild(link);
    }
});}
});