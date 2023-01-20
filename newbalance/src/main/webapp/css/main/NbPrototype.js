/**
 * NAME : NbPrototype.js
 * DESC : Prototype 모음
 * VER  : 1.0
 * Copyright 2015 New Balance Group All rights reserved
 * ============================================================================================
 * 								변		경		사		항
 * ============================================================================================
 * VERSION		DATE		AUTHOR		DESCRIPTION
 * ============================================================================================
 * 1.0		2018.04.05		park.seyoon	최초작성
 */

/**
 * StringBuilder Library
 * @author 	park.seyoon
 * @since 	2018.04.05
 */
function StringBuilder(value) {
	this.strings = new Array("");
	this.append(value);
}
StringBuilder.prototype.append = function (value) {
	if (value)	{
		this.strings.push(value);
	}
};
StringBuilder.prototype.clear = function () {
	this.strings.length = 1;
};
StringBuilder.prototype.toString = function () {
	return this.strings.join("");
};