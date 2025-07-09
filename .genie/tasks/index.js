"use strict";
Object.defineProperty(exports, "__esModule", {
    value: true
});
const _promises = /*#__PURE__*/ _interop_require_default(require("node:fs/promises"));
const _genie = /*#__PURE__*/ _interop_require_wildcard(require("@dashkite/genie"));
function _interop_require_default(obj) {
    return obj && obj.__esModule ? obj : {
        default: obj
    };
}
function _getRequireWildcardCache(nodeInterop) {
    if (typeof WeakMap !== "function") return null;
    var cacheBabelInterop = new WeakMap();
    var cacheNodeInterop = new WeakMap();
    return (_getRequireWildcardCache = function(nodeInterop) {
        return nodeInterop ? cacheNodeInterop : cacheBabelInterop;
    })(nodeInterop);
}
function _interop_require_wildcard(obj, nodeInterop) {
    if (!nodeInterop && obj && obj.__esModule) {
        return obj;
    }
    if (obj === null || typeof obj !== "object" && typeof obj !== "function") {
        return {
            default: obj
        };
    }
    var cache = _getRequireWildcardCache(nodeInterop);
    if (cache && cache.has(obj)) {
        return cache.get(obj);
    }
    var newObj = {
        __proto__: null
    };
    var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor;
    for(var key in obj){
        if (key !== "default" && Object.prototype.hasOwnProperty.call(obj, key)) {
            var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null;
            if (desc && (desc.get || desc.set)) {
                Object.defineProperty(newObj, key, desc);
            } else {
                newObj[key] = obj[key];
            }
        }
    }
    newObj.default = obj;
    if (cache) {
        cache.set(obj, newObj);
    }
    return newObj;
}
_genie.define("clean", function() {
    return Promise.all([
        _promises.default.rm("build", {
            recursive: true,
            force: true
        }),
        _promises.default.rm(".masonry", {
            recursive: true,
            force: true
        })
    ]);
}); //# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiL3Rhc2tzL2luZGV4LmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQSxPQUFPLEVBQVAsTUFBQTs7QUFDQSxPQUFPLENBQUEsU0FBUCxNQUFBOztBQUVBLEtBQUssQ0FBQyxNQUFOLENBQWEsT0FBYixFQUFzQixRQUFBLENBQUEsQ0FBQTtTQUNwQixPQUFPLENBQUMsR0FBUixDQUFZO0lBQ1YsRUFBRSxDQUFDLEVBQUgsQ0FBTSxPQUFOO0lBQ0U7TUFBQSxTQUFBLEVBQVcsSUFBWDtNQUNBLEtBQUEsRUFBTztJQURQLENBREYsQ0FEVTtJQUlWLEVBQUUsQ0FBQyxFQUFILENBQU0sVUFBTjtJQUNFO01BQUEsU0FBQSxFQUFXLElBQVg7TUFDQSxLQUFBLEVBQU87SUFEUCxDQURGLENBSlU7R0FBWjtBQURvQixDQUF0QiIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCBGUyBmcm9tIFwibm9kZTpmcy9wcm9taXNlc1wiXG5pbXBvcnQgKiBhcyBHZW5pZSBmcm9tIFwiQGRhc2hraXRlL2dlbmllXCJcblxuR2VuaWUuZGVmaW5lIFwiY2xlYW5cIiwgLT5cbiAgUHJvbWlzZS5hbGwgW1xuICAgIEZTLnJtIFwiYnVpbGRcIiwgXG4gICAgICByZWN1cnNpdmU6IHRydWVcbiAgICAgIGZvcmNlOiB0cnVlXG4gICAgRlMucm0gXCIubWFzb25yeVwiLCBcbiAgICAgIHJlY3Vyc2l2ZTogdHJ1ZVxuICAgICAgZm9yY2U6IHRydWVcbiAgXVxuICAgICJdfQ==
 //# sourceURL=/tasks/index.coffee

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiIiwic291cmNlcyI6WyIvdGFza3MvaW5kZXguY29mZmVlIl0sInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzQ29udGVudCI6WyJpbXBvcnQgRlMgZnJvbSBcIm5vZGU6ZnMvcHJvbWlzZXNcIlxuaW1wb3J0ICogYXMgR2VuaWUgZnJvbSBcIkBkYXNoa2l0ZS9nZW5pZVwiXG5cbkdlbmllLmRlZmluZSBcImNsZWFuXCIsIC0+XG4gIFByb21pc2UuYWxsIFtcbiAgICBGUy5ybSBcImJ1aWxkXCIsIFxuICAgICAgcmVjdXJzaXZlOiB0cnVlXG4gICAgICBmb3JjZTogdHJ1ZVxuICAgIEZTLnJtIFwiLm1hc29ucnlcIiwgXG4gICAgICByZWN1cnNpdmU6IHRydWVcbiAgICAgIGZvcmNlOiB0cnVlXG4gIF1cbiAgICAiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6Ijs7OztpRUFBQTsrREFDQTs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7QUFFQSxLQUFLLEVBQUMsTUFBTixDQUFhLE9BQWIsRUFBc0IsUUFBQSxDQUFBLENBQUE7V0FDcEIsT0FBTyxDQUFDLEdBQVIsQ0FBWTtRQUNWLGlCQUFFLENBQUMsRUFBSCxDQUFNLE9BQU4sRUFDRTtZQUFBLFNBQUEsRUFBVyxJQUFYO1lBQ0EsS0FBQSxFQUFPO1FBRFAsQ0FERixDQURVO1FBSVYsaUJBQUUsQ0FBQyxFQUFILENBQU0sVUFBTixFQUNFO1lBQUEsU0FBQSxFQUFXLElBQVg7WUFDQSxLQUFBLEVBQU87UUFEUCxDQURGLENBSlU7S0FBWjtBQURvQixDQUF0QiJ9