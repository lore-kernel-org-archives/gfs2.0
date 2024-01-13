Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE6C8814
	for <gfs2@lists.linux.dev>; Sat, 13 Jan 2024 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUZRUytn"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so5877904a12.0
        for <gfs2@lists.linux.dev>; Sat, 13 Jan 2024 01:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705138658; x=1705743458; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e9oqAGJFdxCUWvX+Rhenp1+sIuiXMO95ttMAWtjRwEU=;
        b=GUZRUytnjz6a3Vo9HjpoUbHDh0/0cKWupj1JutSaHB0MtMfug2E/SfKT3iAlYD+i6f
         IA3Kd7yiFFOkndDH6eSY4/7zYUumllSdkyFULuS+fMIHd5jihKiw0ig1LwQ9xPiWFsif
         VZEYHnuAX6EwvxjtSdy/N+5uoniVg+Nz8WOL35w1NX/c0YRdB6x1w4iAQTxpcrRD/k4N
         egpglzQ+aGzxh1Xgpva36E5ZIT0wJVNLZiWftQ5G2QgKkgR1iAV4YNXdIcg4FUQ9dDze
         yT7oGJxhTYXxlt03WiBIvYd2PXLtPtA7Wtb/pvwDIpsQNp0fTMEY4lBJYwhhFg4TUy1B
         TY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705138658; x=1705743458;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9oqAGJFdxCUWvX+Rhenp1+sIuiXMO95ttMAWtjRwEU=;
        b=K3HjFORjWiBn/C+rjsQ32Qd2JFhrzdjwKkCu+RwxFBmqYmz+HOt7MkTow4SQz3kxqy
         zsE52OIbz7r7W8/q8V73Vh19aJwej1UjXwXCVHmTP6rIZs3VL27xF6bLmLDZ0jmJNKTH
         Vi+vqpaL5bMvflSnvgGB2l/z7l+Dpdm2PYPpxQR3jsWL8tvRh/5XKjQJHZ8jc9Ohuhju
         vEmZYg/s/VEvRuQWdG+q383+u7vGaiBAKBULOFrkMWu80lgmAC0BZd4JWMJtKZ/5CquX
         3YFFxaNXko106RpxyscPDUQChpLg1UDA+RIC134sd26gsbOQGqsVzaT7FafXEjPkWSQs
         6nFg==
X-Gm-Message-State: AOJu0YxarygAcEDe7Ixb6pLjDmoCyjH1sQEBjS+Ank5YcEuBijygpNGm
	QTmW0BX1Jvck7ipaVUpoKgQlpB97cyGqEAU2mg+Jarz5E0Ml9EIbkIA=
X-Google-Smtp-Source: AGHT+IGJ+niLGEBc54Drvajyc2eYCZcgBsi4qqyoWQerjpFsuZnUnOLXJyJmnjO4ZVxanr4DvFQjWkZcTYpxXE2PlLQ=
X-Received: by 2002:a17:907:9487:b0:a27:654e:3fd with SMTP id
 dm7-20020a170907948700b00a27654e03fdmr1644408ejc.29.1705138658178; Sat, 13
 Jan 2024 01:37:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+sT36sN+q6+a9JU4=ZLDVhcw+B6+YV4AE-MJZu6wNiXGssN6A@mail.gmail.com>
In-Reply-To: <CA+sT36sN+q6+a9JU4=ZLDVhcw+B6+YV4AE-MJZu6wNiXGssN6A@mail.gmail.com>
From: Mehrdad Dashtbani <mehrdad1374.md@gmail.com>
Date: Sat, 13 Jan 2024 13:07:13 +0330
Message-ID: <CA+sT36tMxSGLWrzZcGB7f7G9_OdG3fT8s=jr=qpdqi+59gbUJw@mail.gmail.com>
Subject: Re: fsck.gfs2 bad read: Input/output error from lgfs2_inode_read:51
To: gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is the full output of fsck.gfs2.

[root@node1 ~]# fsck.gfs2 /dev/sda
Initializing fsck
Gathering information to repair the gfs2 superblock.  This may take some time.
Block size determined to be: 4096
Found system master directory at: 0x2011d
Found system per_node directory at: 0x60337
From per_node's '..' I backtracked the master directory to: 0x2011d
Okay to fix the GFS2 superblock? (y/n)y
bad read: Input/output error from lgfs2_inode_read:51: block
288230926779940864 (0x400008034000000) count: 1 size: 4096 ret: 0
