Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866FE2609FD
	for <gfs2@lists.linux.dev>; Sat, 30 Aug 2025 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548865; cv=none; b=JEvb/JK0kEIf67KR7Jvq6cIu1OybpT9e98QBiFOUXeXnTcrlYNYoLtEfpR9/VI9sH8Fz/r0ifzXtgoVG5HJrPLLXAc7auwHaR9E0GJ9ezcbAWNyoLIZHRMjyhBFZ88jk4pgRScTPtC3OUDqEn/XO65WDeYFQ85dvz5fjVgtZufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548865; c=relaxed/simple;
	bh=IaL7ajgEckNEFeptbQZHtaF473l87dF48nSdgY/pR8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miQSC8DuAw5aM4vFAhkqYsBRKv1sjDbiccgKO4qrPtXU5SKwndqTwIHoJUm7igkZzFNOQ3dQyV6N4NWYyHxHnYY3BiCicIxLyyTii83u2/3Q54GQgeNYxucPzotfRpZtGgC494MnPd2e9FrsipG13OC0n0Sfe2wy3UxIrUAXZnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5O/WHeh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5O/WHeh"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3cef6debedcso1023348f8f.3
        for <gfs2@lists.linux.dev>; Sat, 30 Aug 2025 03:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548861; x=1757153661; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xoi0shITNqEF4SWAsgTXmAWKuaQLzQyyqW+Hmtl3ZaA=;
        b=J5O/WHehnJQ5L/yvXHxsB4ZzyNjdgJ16PyhqEt+wrQLgZEtd1p1JoTMW5iAz6P3tJe
         yA4268Z6h5VqXxId54kQdcRjRswqrQlsDy0CC7R2GI2YxWWRtR0pkV67NY2V5XXThJct
         6AmVieSrNmKnyUM3XF3IVY8xvMxLynx6wBMRk+j5eBQ12KnbfcoqUf7B6nyLLnDICV7K
         keFjwbLvOEwwvaClr0jgcG4Ci3r3Eonmqe2+yRSvHaxRlx8W9SY5tkLPA9/MYET+UJYE
         eBKNqvndd3uM/q41W9NtI2BiSJ8qvL4bWgZQPmIhFO9qlMAK3GQj5tSVAgtbax/jt4n3
         jqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548861; x=1757153661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xoi0shITNqEF4SWAsgTXmAWKuaQLzQyyqW+Hmtl3ZaA=;
        b=wxHn1DvxNoBal2TcLE3R1Q3qHFXdUckBOByzhQSALRHCUK3uH8LnAQbb18UJ+k2zC2
         QFx3N9poJ3/uSDm8hjZU+UBEsyk3MZ+nmImWwHBNVzVXAH4XYCCL+aUrO5N1YWmvWDQV
         O57BeA4FaNDB/JAf8mokXhe/62aed29Y7sT1DSily6wHuy9FQ+Y+RnffbgxDbbsCc62J
         tANOipmZ4aW28dIZ0usBq9wkA6btEEm10pde+wxbe87klIIqNXpDiaknebSIYePRHowK
         naOJ6Mrvy1KJgu4/w1EuASfgL1YupO0aCGZlHgrIiRxI7l6zo0qPw4oxNeSv1tpYQf6t
         D88A==
X-Gm-Message-State: AOJu0YykYVu07gQjM1wbdCX2NFhPsq2vt3DqznMgn92s83yOyctFHjLA
	P69gwYGhsI4fFqqJ6QLWvsURuYE/+9jWjV5AV2W2S+1rsA8w+0fEUqLeJtgpruJugXTOuA==
X-Gm-Gg: ASbGnctKYeTgeYD9jwRMhEAjSzrkpY/3frSl56Xe+doGmIi/X6f4kjVb7P8AmiUufmQ
	U2AheJUuCTqLUg0uUeGozoCtRxE9f8tnIY3oCBFyNp/ApUh3srjth+Wvp9WHXdK/xkj9bsdoILc
	l/cfnXi5s/F2BtGbOh6WoHqsLWAXqYXyeWIyP9nbfBStUaeAEusHjkmg+r2qTTUWo4O/cZMTBEV
	20W+JJfDUcXkr3q0GffXN0ksKsWiMnhKLokV86sN9OP63De2FvMSOZXVktEn/zo0+bzcnIcEj7j
	MRh8qVh7eL9nh+JSj3lKJ1VagFjTOU8EdV0mMWt0S+9KyOKv/9v4m4gLPyi8pNglNDHUyiZ+y/i
	P/PA+cqrsagkfmXGZ2Z+quh6ydr1xQyKZkDLjSUXMxxwRBszDKoyMZr9YBC9LlkHKkTnmdK355d
	sLrYoJobiHsAV7/keLTb6YavT65Ey6tKSyZxHTtK74JWxyS58TDzq9RQvR2yiHGQDQNNP9OLfUf
	Ogrw92q
X-Google-Smtp-Source: AGHT+IHZG6uR9ABulgPhzv60+mohxqvIwSU0wLSEKcNLkRxduymyoeRrKvrt+4O+1/32VjFe9kczrQ==
X-Received: by 2002:a05:6000:144e:b0:3ce:ae6b:51d9 with SMTP id ffacd0b85a97d-3d1dcf57b4fmr1083916f8f.26.1756548861272;
        Sat, 30 Aug 2025 03:14:21 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:20 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 02/12] refactor: handle cases from_dir and from_other in find_rsb_nodir
Date: Sat, 30 Aug 2025 12:14:03 +0200
Message-ID: <20250830101413.602637-2-226562783+SigAttilio@users.noreply.github.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250830101413.602637-1-226562783+SigAttilio@users.noreply.github.com>
References: <20250830101413.602637-1-226562783+SigAttilio@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 fs/dlm/lock.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 5af1840f98d8..0165b3b7e36a 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1007,16 +1007,54 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	 * rsb not found
 	 */
 
+	if (error == -EBADR && !create)
+		goto out;
+
 	error = get_rsb_struct(ls, name, len, &r);
 	if (WARN_ON_ONCE(error))
 		goto out;
 
 	r->res_hash = hash;
 	r->res_dir_nodeid = dir_nodeid;
-	r->res_master_nodeid = dir_nodeid;
-	r->res_nodeid = (dir_nodeid == our_nodeid) ? 0 : dir_nodeid;
 	kref_init(&r->res_ref);
 
+	if (from_dir) {
+		/* want to see how often this happens */
+		log_debug(ls, "find_rsb new from_dir %d recreate %s",
+			  from_nodeid, r->res_name);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+		goto out_add;
+	}
+
+	if (from_other && (dir_nodeid != our_nodeid)) {
+		/* should never happen */
+		log_error(ls, "find_rsb new from_other %d dir %d our %d %s",
+			  from_nodeid, dir_nodeid, our_nodeid, r->res_name);
+		dlm_free_rsb(r);
+		r = NULL;
+		error = -ENOTBLK;
+		goto out;
+	}
+
+	if (from_other) {
+		log_debug(ls, "find_rsb new from_other %d dir %d %s",
+			  from_nodeid, dir_nodeid, r->res_name);
+	}
+
+	if (dir_nodeid == our_nodeid) {
+		/* When we are the dir nodeid, we can set the master
+		   node immediately */
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+	} else {
+		/* set_master will send_lookup to dir_nodeid */
+		r->res_master_nodeid = 0;
+		r->res_nodeid = -1;
+	}
+
+ out_add:
+
 	write_lock_bh(&ls->ls_rsbtbl_lock);
 	error = rsb_insert(r, &ls->ls_rsbtbl);
 	if (error == -EEXIST) {
-- 
2.48.1

