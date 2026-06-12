Received: from send170.i.mail.ru (send170.i.mail.ru [95.163.59.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76933E346;
	Fri, 12 Jun 2026 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272175; cv=none; b=MrB0bs+4KTUvWImIQmNjik+g44c3O4JiSLhfDUvgDuLj8ZbY8qeAwC5qFzwpaaMyO07erYB40UC1k5JZKvaY8YqReRxdI0KjKrtBzQ20ZV4marY09IKshK5guXILMSIIrxiXp6kbW0NC95ilZ9xl8XcHKlMgQpIQLKKlA17kw2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272175; c=relaxed/simple;
	bh=Jh5TZcfm74PxTplLM8bR5rwuotS+skugGYX4diJucoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HkvrYSSN3oKN5E/eNW7qB/J74NIDiGiVOTD3YyZ6Mxcwt1jXYWboz2jOsFVeCh7v8hjFHuqiNEt0PXTD7iTQ8bg5UjbknUhXfpywVjxGf2glOw360tuz1UlY9zAqlJd4ffsHivOxVhIo7s/viUx98Aay2csNbekUGIbIpjuW4IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=vcMYF/a5; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=iL2L7HqS; arc=none smtp.client-ip=95.163.59.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="vcMYF/a5";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="iL2L7HqS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=jONjw6AdiEiZLk8nOzE2K3CfDW3FloUBqB+AxY0HQPs=; t=1781272171; x=1781362171; 
	b=vcMYF/a5dpiC8c51qfesnsqiaa+rXlu+YkCRJIze7cTOEKhyaseaycex8UBUZla+PUdP5hnaPS+
	5wBxFz/3oXxRbKf5EtqvzLlvC5ZOfI40phcduBp5eQOifeO9MAC1m1tL8+8nbwFlLpYSQ/7/NTYuR
	QiMdRhCPdIVvxVzm3CWV/oLvRJZs3JENWNZ4wP9uFtCUmZ62Hpo5BG6MxZjgMZ+x59gWB94JnAf3P
	o3Ld6VpWrkOG7Nz5aZTy9BKc3BBQFkWCCn1x+7dFwAE/zIVTdsWwOR+bNSGSODSu2SwUpLev2XO3d
	WyU1r6OQo/BFlrs+qf/et+KOsJW+M125HI0Q==;
Received: from [10.113.231.175] (port=39926 helo=send276.i.mail.ru)
	by exim-fallback-78b7dd6b8b-7wd4l with esmtp (envelope-from <listdansp@mail.ru>)
	id 1wY2GA-000000003MM-3g5y; Fri, 12 Jun 2026 16:49:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=jONjw6AdiEiZLk8nOzE2K3CfDW3FloUBqB+AxY0HQPs=; t=1781272162; x=1781362162; 
	b=iL2L7HqSfH/eBKalEcs525yu/uozZMuPdeMQd0OVYHMDfHyev+mzNk42u5lJZlC3NwoIWqAkFf/
	YJi3cC64eub8tgoGNqW6Bce5mGUeCB1MMrFFW+4Ltg7Y9jUAMOkzZmFzYhMl8nyK/HwfXcqoBCsHo
	iyv9iY9JoOOu45Tq54lJRbe4lAJ+XUm2XD1mlBYRth8a1I114fSWbrA9tla4BbDkX8utM1Nbjmuuo
	EpP6SZssC5AEZxgpv7tnxcW4+C2FTP3HqWMwiJVyyFORIEGk3nRp4vfht//kpZVFIK/BKBVZ7scAA
	ChYSuqDP5koM0KeHB44sb8O1apP1wQg1wfRA==;
Received: by exim-smtp-5bf699dc9d-2hz2d with esmtpa (envelope-from <listdansp@mail.ru>)
	id 1wY2G0-00000000SE4-0On1; Fri, 12 Jun 2026 16:49:12 +0300
From: Danila Chernetsov <listdansp@mail.ru>
To: Alexander Aring <aahringo@redhat.com>
Cc: Danila Chernetsov <listdansp@mail.ru>,
	David Teigland <teigland@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] dlm: fix NULL pointer dereference in dlm_dump_rsb_name()
Date: Fri, 12 Jun 2026 13:48:46 +0000
Message-Id: <20260612134846.121668-1-listdansp@mail.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9E926CE86FFF978D7583CDF9FC94F487603D3045F055073D0182A05F5380850401C317B48D64553033DE06ABAFEAF67059578FCC19F13152F66ADEA247BA50CAE239A53BAF60AA5ED
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77545ECFDF1E157EBEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB5533756660D1C91D8D479127188297C9764E0A54E4D53AEF9103A8EB15BA2972B446A3CF8EEF46B7454FC60B9742502CCDD46D0DB355ED1E20F5346AF6B57BC7E64490618DEB871D839B73339E8FC8737B5C22498BFD6B1B042489ACCC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C08794E14F7ADDB10D8941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0F0EB20F09E7EDBCC7B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050FB28585415E75ADA9452896749CDDA0A6B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE33AC447995A7AD182BEBFE083D3B9BA73A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4931B544F03EFBC4D57B7122A4C44A4E42FC4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5A5518EE96380C8F25002B1117B3ED6968E5671C686D8EE4DF09842853758E9E5823CB91A9FED034534781492E4B8EEADC3194D76C41E9723C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6595C7819E04F52F0CF3D88314D0E334419290301904C46B16BF91064FF9125FC941A04D4374185C886B8341EE9D5BE9A0AB5A26FD911CB745022366B4AE3141CC5B3C8CAED9BD0E94B721D270AA2B885D14C41F94D744909CE04437D853D7CD20871FE3B1D98EC473624A389F0E278DBF4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVYrk7BQKFwEtlIU1cOckWO1iQaSS7or2ew==
X-Mailru-Sender: 4CE1109FD677D277A25EA9D9B320DF53F2775EB3C7803C99B951B70A5BD4BD8E023A7ADCD776121657755A586E2260F3C53BD13D3F6EEB2F3DDE9B364B0DF289C95E31D8FCF52BE1594FB4C9F0DBF4120D4ABDE8C577C2ED
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4E2E2BB41E7B98C3082F2761B9D301C7796B44DAC61EDEAE4049FFFDB7839CE9E1CA7E6CC45A6DB379FF0DB1857C1F58CE5A522C9276307A96034E26CC79534C23324D68BF6095C1F
X-7FA49CB5: 0D63561A33F958A5818CF7C3630358CF5002B1117B3ED6966F03CDA83464794A8E3074072ED0045E02ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZhqfrW6rxcRxoXJAaMWDS4Q==
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok

The function dlm_dump_rsb_name() is called from receive_rcom_lookup()
when a debug dump is requested via a special RCOM_LOOKUP message with
rc_id == 0xFFFFFFFF.

The resource name passed to dlm_dump_rsb_name() comes from the received
message. There is no guarantee that an RSB with this name exists in the
local hash table.

dlm_search_rsb_tree() returns 0 when the RSB is found and stores a valid
pointer in r. When the lookup fails, it returns -EBADR and leaves r
NULL.

The current error handling is inverted:

    if (!error)
            goto out;

As a result, dlm_dump_rsb() is called only when the lookup fails and r
is NULL, resulting in a NULL pointer dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2d90354027ad ("dlm: merge toss and keep hash table lists into one list")
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
---
 fs/dlm/lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c381e1028446..6f30b3a4fabe 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1421,7 +1421,7 @@ void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len)
 
 	rcu_read_lock();
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-	if (!error)
+	if (error)
 		goto out;
 
 	dlm_dump_rsb(r);
-- 
2.25.1

