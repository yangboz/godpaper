/**
    Javascript Repeater
    http://jsrepeater.devprog.com/
    Version 1.1
    
    Copyright (c) 2008 devprog.com 
    This code is licensed under the MIT Licence
    http://www.opensource.org/licenses/mit-license.php
    
    usage: $('#myDiv').fillTemplate(data);
    Please see the site for details on template formatting
    
**/

(function($) {
    $.fn.fillTemplate = function(obj){
        
        if ($.fn.fillTemplate.rptInstance == null) { 
            $.fn.fillTemplate.rptInstance = new $.fn.fillTemplate.jsRepeater(); 
        }
        
        return this.each(function() {

            if ((this.id == null) || (this.id == undefined)){
                this.innerHTML = "Error: id attribute required";
            } else {
                if (($.fn.fillTemplate.rptInstance.templaters[this.id] == null) || ($.fn.fillTemplate.rptInstance.templaters[this.id] == undefined)){
                    $.fn.fillTemplate.rptInstance.templaters[this.id] = new $.fn.fillTemplate.templater();
                    var node = this.cloneNode(true);
                    $.fn.fillTemplate.rptInstance.templaters[this.id].initialise(this.cloneNode(true));
                }
                this.innerHTML = $.fn.fillTemplate.rptInstance.templaters[this.id].parse(obj);
            }
 
        });
    };
    
    $.fn.fillTemplate.rptInstance = null;
    
    $.fn.fillTemplate.jsRepeater = function(){
        this.templaters = {}; 
    };
    
    $.fn.fillTemplate.templater = function(){
        this.templaters = {}; this.Context = null; this.template = "";
        this.isRoot = true; this.mirrorID = null;
    };
    
    var templater = $.fn.fillTemplate.templater;
    
    templater.prototype.initialise = function(rootNode){
        if ((rootNode.getAttribute) && (rootNode.getAttribute("context"))){
            this.Context = rootNode.getAttributeNode("context").nodeValue;
        }
        for (var i=0; i<rootNode.childNodes.length; i++){
            this.extractSubTemplates(rootNode, rootNode.childNodes[i]);
        }
        if (!this.isRoot){
            var tempNode = document.createElement("div");
            tempNode.appendChild(rootNode.cloneNode(true));
            this.template = tempNode.innerHTML;
        } else { this.template = rootNode.innerHTML; }
        this.template = this.template.replace(/%7B/g, "{");
        this.template = this.template.replace(/%7D/g,"}");
    };
    templater.prototype.initialiseMirror = function(rootNode){
        var tempNode = document.createElement("div");
        tempNode.appendChild(rootNode.cloneNode(false));
        var Marker = document.createTextNode("STATIC");
        tempNode.childNodes[0].appendChild(Marker);
        this.template = tempNode.innerHTML;
    };
    templater.prototype.parseOrdering = function(template, ordinal, total){
        template = template.replace(/%{([^}]*)}/g,
            function(match, group1){
                var first = null; 
                var alternates = null;
                var last = null;
                
                if (group1.indexOf("|") > -1){
                    var ary = group1.split("|");
                    first = ary[0];
                    alternates = ary[1];
                    if (ary.length > 2) { last = ary[2]; }
                } else {
                    alternates = group1;
                }
                alternates = alternates.split(":");
                
                if ((ordinal == 0) && (first != null)) { return first; }
                if ((ordinal == total - 1) && (last != null)) { return last; }
                return alternates[ordinal % alternates.length];
            });
            return template;
    };
    templater.prototype.parseRecursionOrdering = function(template, data, recursionCount, ob){
        template = template.replace(/!%{([^}]*)}/g,
            function(match, group1){
                var first = null; 
                var alternates = null;
                var last = null;
                
                if (group1.indexOf("|") > -1){
                    var ary = group1.split("|");
                    first = ary[0];
                    alternates = ary[1];
                    if (ary.length > 2) { last = ary[2]; }
                } else {
                    alternates = group1;
                }
                alternates = alternates.split(":");
                
                if ((recursionCount == 0) && (first != null)) { return first; }
                //if ((ordinal == total - 1) && (last != null)) { return last; }
                return alternates[recursionCount % alternates.length];
            });
            return template;
    };
    templater.prototype.parseNumbering = function(template, ordinal, total){    
        template = template.replace(/#{([^}]*)}/g,
            function(match, group1){
                return ordinal + 1;
            });
            return template;
    };
    templater.prototype.parseRecursive = function(template, data, recursionCount, ob){

    template = template.replace(/!{([^}]*)}/g,
        function(match, group1){
            if (group1 > recursionCount){
                if (ob.Context == null) { return ""; }
                var contextData = data[ob.Context];
                if ((contextData == null) || (contextData == undefined)) { return ""; }
                return ob.parse(data, recursionCount + 1);
            } else { return ""; }
        });
        return template;
    };
    templater.prototype.parse = function(data, recursionCount){
        var result = ""; 
        var self = this;
        if (this.mirrorID){
            result += this.template.replace(/(STATIC)/g,                
                    function(match, group1) {    
                        return document.getElementById(self.mirrorID).innerHTML;    
                             
                    } ); 
            return result;
        }
        if ((recursionCount == null) || (recursionCount == undefined)) { recursionCount = 0; }
        var contextData = null;
        if (this.Context) { contextData = data[this.Context]; } else { contextData = data; }
        if ((contextData == null) || (contextData == undefined)) {   contextData = {}; }
        if (contextData instanceof Array) {    
            for(var i = 0; i < contextData.length; i++){
                var obj = contextData[i];
                result += this.template.replace(/\$\{([^}]*)\}/g,                
                    function(match, group1) { 
                        var outer = group1.split(":");
                        var val = outer[0];
                        var f = null;
                        if (outer.length > 1) { f = outer[1]; }
                        var ary = val.split(".");
                        var newObj = obj;
                        
                        for(var j=0; j<ary.length; j++){
                            newObj = newObj[ary[j]];
                            
                            if (newObj == undefined) { 
                                if (f != null) { return eval(f + '(newObj);'); }
                                else { return newObj; }   
                            }
                        }  
                        if (f != null) { return eval(f + '(newObj);'); }
                        else { return newObj; }               
                    } ); 
                 var self = this;   
                    result = this.parseNumbering(result, i, contextData.length);
                    result = this.parseRecursionOrdering(result, contextData[i], recursionCount, this);
                    result = this.parseOrdering(result, i, contextData.length);
                    
                    result = this.parseRecursive(result, contextData[i], recursionCount, this);
                    
                
                result = result.replace(/\~\{([^}]*)\}/g,            
                        function(match, group1) {      
                                    return self.templaters[group1].parse(contextData[i]);       
                                } );                            
            }
        } else {
            var obj = contextData; 

            result += this.template.replace(/\$\{([^}]*)\}/g,                
                    function(match, group1) { 
                        var outer = group1.split(":");
                        var val = outer[0];
                        var f = null;
                        if (outer.length > 1) { f = outer[1]; }
                             
                        ary = val.split(".");
                        var newObj = obj;
                        
                        for(var j=0; j<ary.length; j++){
                            newObj = newObj[ary[j]];
                            
                            if (newObj == undefined) { 
                                if (f != null) { return eval(f + '(newObj);'); }
                                else { return newObj; }
                             }
                        }  
                        if (f != null) { return eval(f + '(newObj);'); }
                                else { return newObj; }         
                    } );
              var self = this;      
                    result = this.parseNumbering(result, i, contextData.length);
                    result = this.parseRecursionOrdering(result, contextData, recursionCount, this);
                    result = this.parseOrdering(result, 0, 1);
                    
                    result = this.parseRecursive(result, contextData, recursionCount, this);
                    
            
            result = result.replace(/\~\{([^}]*)\}/g,            
            function(match, group1) {      
                        return self.templaters[group1].parse(contextData);       
                    } );  
        }  
        
        return result; 
    };
    templater.prototype.extractSubTemplates = function(sourceTree, node){
        var plucked = null;
        var markerID = null;
        var markerNode = null;
        var Subtemplater = null;
        if ((node.getAttribute) && (node.getAttribute("template"))){
            plucked = node;
            markerID = this.newGuid();
            markerNode = document.createTextNode("~{" + markerID + "}");
            sourceTree.replaceChild(markerNode, node);
            Subtemplater = new $.fn.fillTemplate.templater();
            Subtemplater.isRoot = false;
            Subtemplater.mirrorID = node.getAttributeNode("ID").nodeValue;
            this.templaters[markerID] = Subtemplater;
            Subtemplater.initialiseMirror(plucked);
            return;
        }
        if ((node.getAttribute) && (node.getAttribute("context"))){

        plucked = node;
        markerID = this.newGuid();
        markerNode = document.createTextNode("~{" + markerID + "}");

        sourceTree.replaceChild(markerNode, node);
        
        Subtemplater = new $.fn.fillTemplate.templater();
        Subtemplater.isRoot = false;
        this.templaters[markerID] = Subtemplater;
        Subtemplater.initialise(plucked);
        }
        else {
            for (var i=0; i<node.childNodes.length; i++){
                this.extractSubTemplates(node, node.childNodes[i]);
            }
        }
    };
    templater.prototype.S4 = function(){
        return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
    };  
    templater.prototype.newGuid = function(){
        return (this.S4()+this.S4()+"-"+this.S4()+"-"+this.S4()+"-"+this.S4()+"-"+this.S4()+this.S4()+this.S4()).toUpperCase();
    };
    

})(jQuery);