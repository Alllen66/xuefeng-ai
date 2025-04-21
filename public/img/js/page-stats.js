// 获取当前页面唯一标识（可用 .pathname 或 .permalink）
const pageId = location.pathname.replace(/\//g, "_") || "home";

// 阅读量统计
const viewRef = firebase.database().ref("views/" + pageId);
viewRef.transaction(current => (current || 0) + 1);
viewRef.on("value", snapshot => {
  document.getElementById("view-count").innerText = snapshot.val() || 1;
});

// 点赞统计
const likeRef = firebase.database().ref("likes/" + pageId);
likeRef.on("value", snapshot => {
  document.getElementById("like-count").innerText = snapshot.val() || 0;
});
document.getElementById("like-btn").onclick = function() {
  // 防止重复点赞（可用 localStorage 或 Firebase Auth 匿名用户）
  if (localStorage.getItem("liked_" + pageId)) return alert("你已点赞过！");
  likeRef.transaction(current => (current || 0) + 1);
  localStorage.setItem("liked_" + pageId, "1");
};