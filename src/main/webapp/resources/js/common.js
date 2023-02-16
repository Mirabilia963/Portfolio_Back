const fe = async function (url, config) {
	const res = await fetch(url, config);
	if (!res.ok) {
		console.log(res);
	};
	return await res.json();
};
